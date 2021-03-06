class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader: (options: file, fog)
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/users/#{model.id}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/default_avatar/#{version_name || :normal}.jpg"
  end

  # Create different versions of your uploaded files:
  version :small  do process resize_to_fill: [20,   20] end
  version :thumb  do process resize_to_fill: [60,   60] end
  version :normal do process resize_to_fill: [100, 100] end
  version :large  do process resize_to_fill: [200, 200] end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
#  def extension_white_list
#    %w(jpg jpeg gif png)
#  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      ext = original_filename.split('.').last
      "image.#{ext}"
    end
  end

end
