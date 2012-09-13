ActiveAdmin.register Photo do
  filter :name, :label => 'Name'

  index :as => :grid, :columns => 4 do |photo|
    div do
      a :href => admin_photo_path(photo) do
        image_tag(photo.image.url(:normal), style: 'border:4px solid #fff; 
  -webkit-box-shadow: 0 0 4px rgba(0, 0, 0, .4);
     -moz-box-shadow: 0 0 4px rgba(0, 0, 0, .4);
          box-shadow: 0 0 4px rgba(0, 0, 0, .4);')
      end
    end
    a truncate(photo.title), :href => admin_photo_path(photo), :style => 'width:100px;display:block;text-align:center;text-decoration:none;font-weight:bold;'

    #link_to image_tag(photo.image.url(:normal)), admin_photo_path(photo), title: photo.name
  end

=begin
    column :photo do |photo|
    end
    column :name do
      link_to photo.name, admin_photo_path(photo)
    end
    column 'Actions' do |photo|
      link_to(image_tag('/assets/view.png'), admin_photo_path(photo), class: 'member_link view_link', title: 'View Photo') +
      link_to(image_tag('/assets/edit.png'), edit_admin_photo_path(photo), class: 'member_link edit_link', title: 'Edit Photo') +
      link_to(image_tag('/assets/delete.gif'), admin_photo_path(photo), confirm: 'Are you sure?', method: :delete, class: 'member_link delete_link', title: 'Delete Photo')
    end
  end
=end
  show :title => :name do |photo|
    attributes_table do
      row :photo do
        image_tag photo.image_url, dimensions(:normal)
      end
      row :name
    end
  end
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Photo", :multipart => true do 
      f.input :image_cache, :as => :hidden 
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url(:thumb)) 
      f.input :name
    end
    f.buttons
  end  
end
