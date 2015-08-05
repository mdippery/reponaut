require 'reponaut'
require 'vcr'

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'fixtures/cassettes'
  vcr.hook_into :webmock
end
