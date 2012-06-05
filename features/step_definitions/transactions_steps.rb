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

Then /^I should see my monthly income as "(.*?)"$/ do |amount|
  page.has_content? "Income: #{ amount }"
end

Then /^I should see my monthly outgoing as "(.*?)"$/ do |amount|
  page.has_content? "Outgoing: #{ amount }"
end
