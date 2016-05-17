def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require 'reponaut/command'
require 'reponaut/github'
require 'reponaut/statistics'
require 'reponaut/version'

require_all 'reponaut/commands'
