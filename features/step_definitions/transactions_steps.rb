Given /^I am on my transactions page$/ do
  visit transactions_path
end

Given /^I fill in type as "(.*?)"$/ do |type|
  fill_in "Type", :with => type
end

When /^I fill the amount as "(.*?)"$/ do |amount|
  fill_in "Amount", :with => amount
end

When /^submit as income$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see my monthly total as "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
