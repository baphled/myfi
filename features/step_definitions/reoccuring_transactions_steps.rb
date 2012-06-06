When /^I fill in that it starts from today$/ do
  fill_in "Starting from", :with => Date.today
end

When /^it stops reoccuring in (\d+) months$/ do |months|
  fill_in "Reoccuring until", :with => Date.today.advance( :months => months.to_i )
end
