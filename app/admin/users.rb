ActiveAdmin.register User do
  filter :name, :label => 'First Name'
  filter :name, :label => 'Last Name'
  filter :name, :label => 'E-mail'
  filter :name, :label => 'Username'

  action_item do
    link_to "Friends", "/admin/users/#{current_user.id}/friends"
  end

  index do
    column :photo do |user|
      image_tag(user.avatar_url, width: 30, height: 30)
    end
    column :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :username
    column :email

    column :role do |user|
      user.is?(:admin) ? status_tag('admin', :error) : status_tag('member', :warning)
    end

    column 'Actions' do |user|
      link_to(image_tag('/assets/view.png'), admin_user_path(user), class: 'member_link view_link', title: 'View User') +
      link_to(image_tag('/assets/edit.png'), edit_admin_user_path(user), class: 'member_link edit_link', title: 'Edit User') +
      link_to(image_tag('/assets/delete.gif'), admin_user_path(user), confirm: 'Are you sure?', method: :delete, class: 'member_link delete_link', title: 'Delete User')
    end
  end

  show :title => :name do |user|

    attributes_table do
      row :photo do
        image_tag user.avatar_url, dimensions(:thumb)
      end
      row :name
      row :username
      row :email
      row :role do |user|
        user.is?(:admin) ? status_tag('admin', :error) : status_tag('member', :warning)
      end
      row :facebook do |user|
        link_to(image_tag('/assets/icon1.gif', width: 20, height: 20), "http://www.facebook.com/#{user.facebook_id}", title: 'View User')
      end
    end
   end

  member_action :friends do
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  member_action :import_friends do
    current_user.update_role
    if friend = current_user.get_friend(params[:friend_id])
      attrs =  {
        facebook_id:       friend.identifier,
        remote_avatar_url: friend.picture,
        first_name:        friend.first_name,
        last_name:         friend.last_name,
        username:          friend.username,
        guest_of:          (current_user.bride? ? 'bride' : 'groom')
      }

      if guest = Guest.create(attrs)
        redirect_to admin_guest_path(guest), notice: 'Guest successfully added!'
      else
        redirect_to  "/admin/users/#{current_user.id}/friends", notice: 'Error adding guest. Guest was not added.'
      end
    else
      redirect_to  "/admin/users/#{current_user.id}/friends", notice: 'Could not find friend information. Guest was not added.'
    end

  end

  
end