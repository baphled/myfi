Given /^I am on my new transaction page$/ do
  visit new_transaction_path
end

Given /^I fill in type as "(.*?)"$/ do |type|
  fill_in "Type", :with => type
end

When /^I fill the amount as "(.*?)"$/ do |amount|
  fill_in "Amount", :with => amount
end

When /^submit as income$/ do
  click_button "Income"
end

When /^submit as outgoing$/ do
  click_button "Outgoing"
end

When /^I visit my monthly income next month$/ do
  start_of_the_month = Date.tomorrow.next_month
  Timecop.freeze start_of_the_month
  visit new_transaction_path
end

Then /^I should see my monthly income as "(.*?)"$/ do |amount|
  find('.income').should have_content "Income: #{amount}"
end

Then /^I should see my monthly outgoing as "(.*?)"$/ do |amount|
  find('.outgoing').should have_content "Outgoing: #{amount}"
end

When /^I check it as "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in "created at" as next month$/ do
  fill_in "Created at", :with => Date.today.next_month
end

Then /^I should see my monthly total as "(.*?)"$/ do |amount|
  find('.total').should have_content "Total: #{amount}"
end
