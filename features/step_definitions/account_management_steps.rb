Given /^I successfully fill in the signup form$/ do
  fill_in "Email", :with => 'y@me.com'
  fill_in "Password", :with => 'password'
  fill_in "Password confirmation", :with => 'password'
end

Given /^I am signed in to my account$/ do
  step %{I am on the login page}
  step %{I fill in "Email" with "#{@user.email}"}
  step %{I fill in "Password" with "#{@user.password}"}
  step %{I press "Signin"}
end

When /^submit the signup form$/ do
  click_button 'Create account'
end

Given /^I am a registered user$/ do
  @user = User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password'
end

Given /^I am on the signup page$/ do
  visit new_users_path
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

Then /^I should still be signed in$/ do
  find('.login-status').should have_content "Signed in as: #{@user.email}"
end

Then /^I should see the flash message "(.*?)"$/ do |message|
  find('.alert-success').should have_content message
end
