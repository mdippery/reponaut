lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reponaut/version'

Gem::Specification.new do |gem|
  gem.name          = 'reponaut'
  gem.version       = Reponaut::VERSION
  gem.licenses      = ['MIT']
  gem.authors       = ['Michael Dippery']
  gem.email         = ['michael@monkey-robot.com']
  gem.homepage      = 'https://github.com/mdippery/reponaut'
  gem.description   = 'Analysis tool for GitHub users'
  gem.summary       = "Analyzes GitHub users' profiles"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|fixtures)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.0.0'

  gem.add_runtime_dependency('httparty', '~> 0.13.5')
  gem.add_runtime_dependency('json', '~> 1.8')
  gem.add_runtime_dependency('mercenary', '~> 0.3.5', '!= 0.3.6')

  gem.add_development_dependency('aruba', '~> 0.8')
  gem.add_development_dependency('cucumber', '~> 2.0')
  gem.add_development_dependency('rspec', '~> 3.3')
  gem.add_development_dependency('vcr', '~> 3.0')
  gem.add_development_dependency('webmock', '~> 2.0')
end
