Given /^I have filled in "(.*?)" with "(.*?)"$/ do |property, value|
  fill_in property, :with => value
end

Given /^I check "(.*?)"$/ do |option|
  check option 
end

When /^I view my latest outgoing transaction$/ do
  visit outgoing_path Outgoing.last
end

Given /^the transaction starts today$/ do
  fill_in "Starting from", :with => Date.today
end

When /^I visit my monthly outgoing next month$/ do
  @time_travelled = Date.today + 1.months
  Timecop.freeze @time_travelled
  visit new_transaction_path
end

When /^I add my (.*?) transaction$/ do |transaction_type|
  click_button transaction_type.capitalize
end

When /^I visit my monthly outgoing in another months time$/ do
  @time_travelled += 1.month
  Timecop.travel @time_travelled
  visit new_transaction_path
end

When /^I visit my monthly income in another months time$/ do
  @time_travelled += 1.month
  Timecop.travel @time_travelled
  visit new_transaction_path
end

When /^I visit my monthly income in a total of (\d+) months$/ do |arg1|
  @time_travelled = 3.months
  Timecop.travel @time_travelled
  visit new_transaction_path
end

