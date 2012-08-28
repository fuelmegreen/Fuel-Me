class Account < ActiveRecord::Base
  include SocialUtils

  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  attr_accessible :provider, :uid, :username, :email, :avatar, :remote_avatar_url, :avatar_cache

  before_validation do
    [:provider, :uid, :username, :email].each do |field|
      self[field].strip.downcase if self[field].is_a?(String)
    end
  end

  validates :provider, presence: true, length: 2..64, :inclusion => RConfig[:account_providers]
  validates :uid,      presence: true, length: 1..255
  validates :username, allow_nil: true, length: 4..64,  format: RConfig[:regexp].alias
  validates :email,    allow_nil: true, length: 3..255, format: RConfig[:regexp].email 

  scope :on, lambda {|provider| where('provider = ?', provider) } 
  scope :on_facebook, where('provider = ?', 'facebook')
  scope :on_twitter, where('provider = ?', 'facebook')

  class << self

    ##
    # Find existing user with id from omniauth data, or create new user if it doesn't exist.
    def from_omniauth(auth, user=nil)
      find_with_omniauth(auth) || create_with_omniauth(auth, user)
    end

    ##
    # Find user in database with credentials from omniauth data
    def find_with_omniauth(auth)
      where(provider: auth.try(:provider), uid: auth.try(:uid)).first
    end

    ##
    # Create user from omniauth data
    def create_with_omniauth(auth, user=nil)
      logger.info "PASSED EXISTING USER: #{user.inspect}"
      user ||= User.from_omniauth(auth)
      create! do |account|
        account.user_id  = user.id
        account.provider = auth.provider
        account.uid      = auth.uid
        account.email    = auth.info.email || user.email
        account.username = auth.info.username || auth.info.nickname || linkedin_username(auth)
        account.token    = auth.credentials.token
        account.secret   = auth.credentials.secret
        account.remote_avatar_url = auth.info.image if auth.info.image.present?
      end
    end 

    def method_missing method, *args, &block
      if method.to_s.in?(RConfig[:account_providers])
        find(:first, :conditions => {:provider => method.to_s})
      else
        super
      end
    end

  end # class << self

  def to_s
    "#{provider}:#{uid}"
  end

end
