lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locum_best_practices/version'

Gem::Specification.new do |spec|
  spec.name          = 'locum-best-practices'
  spec.version       = LocumBestPractices::VERSION
  spec.authors       = %w(DarkWater)
  spec.email         = %w(darkwater666@mail.ru)

  spec.summary       = 'Simple best practices, used for soft deployment to locum hosting'
  spec.description   = 'Contains deploy configuration'
  spec.homepage      = 'https://github.com/DarkWater666/locum-best-practices'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^(test|spec|features)/) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(/^exe/) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency 'bundler', '~> 1.10.0'
  spec.add_development_dependency 'rake', '~> 10.0.0'

  spec.add_development_dependency 'redcarpet', '~> 1.17.0'
  spec.add_development_dependency 'yard', '~> 0.7.5'

  spec.add_dependency 'capistrano', '~> 3.4.0'
  spec.add_dependency 'capistrano-rails', '~> 1.1.0'
  spec.add_dependency 'capistrano-rvm', '~> 0.1.0'
  spec.add_dependency 'capistrano3-unicorn', '~> 0.2.0'
  spec.add_dependency 'capistrano-rails-console', '~> 1.0.0'

  spec.add_development_dependency 'rubocop', '>= 0.3.0'
end
