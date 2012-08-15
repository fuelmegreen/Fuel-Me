config = File.open(File.join(CONFIG_ROOT, 'account_providers.yml'))
providers = YAML.load(config).symbolize_keys 

Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |name, credentials|
    if credentials['options']
      provider name, credentials['key'], credentials['secret'], credentials['options']
    else
      provider name, credentials['key'], credentials['secret']
    end
  end
end