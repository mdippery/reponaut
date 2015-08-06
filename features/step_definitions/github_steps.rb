Given /^the GitHub service returns repository data for the user "([^"]*)"$/ do |username|
  VCR.insert_cassette('repos')
end
