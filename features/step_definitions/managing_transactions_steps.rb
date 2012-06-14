When /^I view the last create income entry$/ do
  visit income_path Income.last
end

When /^I view the last create outgoing entry$/ do
  visit outgoing_path Outgoing.last
end

When /^I choose to remove the item$/ do
  click_link "Delete"
end
