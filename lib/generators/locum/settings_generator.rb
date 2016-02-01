module Locum
  class SettingsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Add default application settings'
    def add_capistrano_templates
      directory 'settings', '.'
    end
  end
end
