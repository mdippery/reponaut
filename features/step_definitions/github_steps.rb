Given /^the GitHub service returns repository data for the user "([^"]*)"$/ do |username|
  set_environment_variable 'REPONAUT_ENV', 'cucumber'
end

Given /^the GitHub service returns 404 for the user "([^"]*)"$/ do |username|
  set_environment_variable 'REPONAUT_ENV', 'cucumber'
end

Given /^the GitHub service is rate limiting requests for the user "([^"]*)"$/ do |username|
  set_environment_variable 'REPONAUT_ENV', 'cucumber'
  set_environment_variable 'REPONAUT_RATE_LIMIT', 'on'
end
