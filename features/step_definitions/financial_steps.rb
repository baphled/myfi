Then /^I should "(.*?)" for "(.*?)"$/ do |value, type|
  find(".#{type.parameterize}").should have_content "#{type} - #{value}"
end
