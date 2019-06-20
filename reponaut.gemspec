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

  gem.metadata = {
    'build_date'  => Time.now.strftime("%Y-%m-%d %H:%M:%S %Z"),
    'commit'      => `git describe 2>/dev/null`.chomp,
    'commit_hash' => `git rev-parse HEAD`.chomp,
  }

  gem.required_ruby_version = '>= 2.0.0'

  gem.add_runtime_dependency('httparty', '~> 0.17.0')
  gem.add_runtime_dependency('json', '~> 2.0')
  gem.add_runtime_dependency('mercenary', '~> 0.3.5', '!= 0.3.6')

  gem.add_development_dependency('aruba', '~> 0.8')
  gem.add_development_dependency('cucumber', '~> 3.0')
  gem.add_development_dependency('rspec', '~> 3.3')
  gem.add_development_dependency('vcr', '~> 5.0')
  gem.add_development_dependency('webmock', '~> 3.0')
end
