module Locum
  class DeployGenerator < Rails::Generators::Base
    desc <<-EOF
Prepares application to deploy and add custom stages. `testing` and `production` stages are created by default.
    EOF

    argument :stages, type: :array, default: [], banner: 'custom stages'
    source_root File.expand_path('../templates', __FILE__)

    def add_deploy_templates
      directory 'deploy', '.'
    end
  end
end
