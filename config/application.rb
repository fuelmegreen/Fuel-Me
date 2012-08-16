require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  required = [:utils, :security, :omniauth, :images, :apis]
  dev_test = Rails.groups(:assets => %w(development test))
  Bundler.require(*required, *dev_test)
end

module FuelMe
  class Application < Rails::Application

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W[
      #{config.root}/lib
      #{config.root}/lib/*
      #{config.root}/lib/**/*
      #{config.root}/lib/core_ext/*
    ]
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:passwd, :password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Devise Config
    config.to_prepare do
      Devise::SessionsController.layout 'login'
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "login" }
    end
  end
end

CONFIG_ROOT = File.join(Rails.root, 'config') unless defined? CONFIG_ROOT

require 'addressable/uri'
