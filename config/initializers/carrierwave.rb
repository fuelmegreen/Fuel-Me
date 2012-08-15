cw_config = File.open(File.join(CONFIG_ROOT, 'carrierwave.yml'))
cw_config = YAML.load(cw_config).symbolize_keys

CarrierWave.configure do |config|

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')

  case Rails.env.to_sym
  when :development
    config.storage = :file
    config.root = File.join(Rails.root, 'public')
  when :production
    # the following configuration works for Amazon S3
    config.storage          = :fog
    config.fog_credentials  = cw_config[:aws_credentials].symbolize_keys
    config.fog_directory    = cw_config[:s3_bucket]
  else
    # settings for the local filesystem
    config.storage = :file
    config.root = File.join(Rails.root, 'public')
  end

end