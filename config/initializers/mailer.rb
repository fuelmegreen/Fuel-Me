config   = File.open(File.join(CONFIG_ROOT, 'mailer.yml'))
settings = YAML.load(config)[Rails.env]

ActionMailer::Base.smtp_settings = settings
