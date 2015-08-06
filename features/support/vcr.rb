require 'vcr'
require 'webmock/cucumber'

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'spec/fixtures/cassettes'
  vcr.hook_into :webmock
end

After do
  VCR.eject_cassette('repos')
end
