Given /^I successfully fill in the signup form$/ do
  fill_in "email", :with => 'y@me.com'
  fill_in "password", :with => 'password'
  fill_in "password_confirmation", :with => 'password'
end

When /^submit the signup form$/ do
  click_button 'Create account'
end

Given /^I am a registered user$/ do
  User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password'
end

Given /^I am on the login page$/ do
  visit new_session_path
end

Given /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, :with => value
end

When /^I press "(.*?)"$/ do |button_title|
  click_button button_title
end

Then /^I should see the flash message "(.*?)"$/ do |message|
  find('.alert-success').should have_content message
end
