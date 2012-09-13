def time_in_words time
  return unless time
  word = (Time.now - time) < 0 ? 'from now' : 'ago'
  "#{time_ago_in_words(time)} #{word}"
end

ActiveAdmin::Dashboards.build do

  section 'Users' do
    table_for User.all do
      column("Photo")  {|user| link_to image_tag(user.avatar_url, width: 30, height: 30), admin_user_path(user) }
      column("Name")   {|user| link_to user.name, admin_user_path(user)                                         }
      column("E-mail") {|user| email_link(user.email)                                                           }
    end
  end
 
  section 'Projects' do
    table_for Project.all do
      column("Name")        { |project| link_to project.name, admin_project_path(project) }
      column("Version")     { |project| status_tag project.version                        }
      column("Description") { |project| project.description                               }
    end
  end

  section 'Photos' do
    table_for Photo.all do
      column("Photo")   {|photo| link_to image_tag(photo.image_url, width: 30, height: 30), admin_photo_path(photo) }
      column("Name")    {|photo| link_to photo.name, admin_photo_path(photo)                                        }
    end
  end

end
