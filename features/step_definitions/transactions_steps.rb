Given /^I am on my new transaction page$/ do
  visit new_transaction_path
end

When /^I visit my monthly income next month$/ do
  start_of_the_month = Time.now.advance :months => 1
  Timecop.freeze start_of_the_month
  visit new_transaction_path
end

When /^I add my "(.*?)" at "(.*?)" as my "(.*?)"$/ do |type, amount, transaction_type|
  fill_in "Type", :with => type
  fill_in "Amount", :with => amount
  click_button transaction_type.capitalize
end

When /^I add my "(.*?)" at "(.*?)" as my "(.*?)" for next month$/ do |type, amount, transaction_type|
  fill_in "Type", :with => type
  fill_in "Amount", :with => amount
  fill_in "Created at", :with => Date.today.next_month
  click_button transaction_type.capitalize
end

When /^I add a reoccuring "(.*?)" of "(.*?)" as my "(.*?)" from today to 6 months$/ do |transaction_type, amount, type|
  fill_in "Type", :with => type
  fill_in "Amount", :with => amount
  fill_in "Reoccuring until", :with => Date.today.advance( :months => 6)
  fill_in "Starting from", :with => Date.today
  check 'Reoccuring'
  click_button transaction_type.capitalize
end

Then /^I should see my monthly income as "(.*?)"$/ do |amount|
  find('.income').should have_content "Income: #{amount}"
end

Then /^I should see my monthly outgoing as "(.*?)"$/ do |amount|
  find('.outgoing').should have_content "Outgoing: #{amount}"
end

When /^I check it as "(.*?)"$/ do |check_box|
  check check_box
end

When /^I visit my monthly income in (\d+) months$/ do |months_passed|
  start_of_the_month = Time.now.advance :months => months_passed.to_i
  Timecop.freeze start_of_the_month
  visit new_transaction_path
end

Then /^I should see my monthly total as "(.*?)"$/ do |amount|
  find('.total').should have_content "Total: #{amount}"
end
