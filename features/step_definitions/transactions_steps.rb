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

Then /^I should see my monthly total as "(.*?)"$/ do |amount|
  page.has_content? "Income: #{ amount }"
end
