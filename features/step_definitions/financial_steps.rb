Then /^I should "(.*?)" for "(.*?)"$/ do |value, type|
  find(".#{type.parameterize}").should have_content "#{type} - #{value}"
end

Then /^I should see that I spent the most of "(.*?)"$/ do |type|
  find('.spent-most').should have_content "Spent the most on #{type}"
end

Then /^I should see that my main income is "(.*?)"$/ do |type|
  find('.receive-most').should have_content "Receive the most from #{type}"
end
