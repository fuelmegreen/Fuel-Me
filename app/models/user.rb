class User < ActiveRecord::Base
  extend FriendlyId

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :authentication_keys => [:login]

  mount_uploader :avatar, AvatarUploader

  store :preferences, accessors: [:email_notifications, :text_notifications]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :first_name, :last_name, :username, :avatar, :email, :login, :password, :password_confirmation,
                  :remember_me, :remote_avatar_url, :avatar_cache, :preferences, :bio

  validates :first_name, :last_name, presence: true, length: 2..40,  format: RConfig[:regexp].name
  validates :email,                  presence: true, length: 3..255, format: RConfig[:regexp].email
  validates :username,               presence: true, length: 4..50,  format: RConfig[:regexp].alias
  validates :password,               presence: true, length: 6..12,  confirmation: true, if: :password_required?
  validates :terms_of_service,       acceptance: true
  validates_uniqueness_of :email, :username, case_sensitive: false

  friendly_id :username

  attr_accessor :login

  ROLES = %w[ admin member user ] # NOTE: do not change the order

  class << self
    def new_with_session(params, session)
      super.tap do |user|
        user.attributes.merge!(session[:user]) if session[:user]
        user.attributes.merge!(params) if params
        set_from_omniauth user, session[:omniauth] if session[:omniauth]
      end
    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
    end

    ##
    # Find existing user with id from omniauth data, or create new user if it doesn't exist.
    def from_omniauth(auth)
      (auth.info.email.present? && find_by_email(auth.info.email)) || create_with_omniauth(auth)
    end

    ##
    # Create user from omniauth data
    def create_with_omniauth(auth)
      new do |user|
        set_from_omniauth user, auth
      end
    end

    def set_from_omniauth(user, auth, set_password=false)
      user.name       = auth.info.name if auth.info.name?
      user.first_name = auth.info.first_name if auth.info.first_name?
      user.last_name  = auth.info.last_name if auth.info.last_name?
      user.email      = auth.info.email
      user.username   = auth.info.username || auth.info.nickname || linkedin_username(auth)
      user.bio        = auth.info.bio || auth.info.description || auth.info.headline 
      #user.remote_avatar_url = auth.info.image if auth.info.image?
      # if set_password
      #   user.password = 'password'
      #   user.password_confirmation = 'password'
      # end
    end

    def name_from_omniauth(user, auth)
    end

    def linkedin_username(auth)
      return unless auth.provider == 'linkedin'
      if url = auth.info.urls.public_profile
        url[url.rindex('/')+1..-1]
      end
    end

  end # class << self

  def apply_omniauth(auth)
    self.first_name omniauth.info.first_name if first_name.blank?
    self.last_name omniauth.info.last_name if last_name.blank?
    self.email = omniauth.info.email if email.blank?
    accounts.build(provider: omniauth.provider, uid: omniauth.uid, email: omniauth.info.email)
  end

  def name
    [first_name, last_name].compact.join(' ')
  end
  alias_method :full_name, :name
  alias_method :to_s, :name

  def name=(name)
    self.first_name, self.last_name = name.to_s.split(' ', 2)
  end
  alias_method :full_name=, :name=

  # === Examples ===
  #   'admin,seller'
  #   => ['admin', 'seller']
  def roles=(roles)
    return unless roles
    roles = roles.split(',').map(&:strip) unless roles.kind_of?(Array)
    self.roles_mask = (roles & ROLES).map {|r| 2**ROLES.index(r) }.sum
  end

  # === Examples ===
  #   ['admin', 'seller']
  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  # === Examples ===
  #   'admin, seller'
  def formatted_roles
    self.roles.join(', ')
  end

  def formatted_phone
    return unless phone.present?
    "(%s) %s-%s" % [phone[0,3], phone[3,3], phone[6,4]]
  end

  def is?(role)
    roles.include?(role.to_s)
  end
   
  def ===(role)
    is?(role)
  end

  def admin?
    is?(:admin)
  end

  # Admins have all the rights of Members
  def member?
    admin? || is?(:member)
  end

  # Admins and Members have all the rights of Users
  def user?
    admin? || member? || is?(:user)
  end

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    password.present?
  end

end
