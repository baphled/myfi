Feature: I want to be able to add my monthly income
  In order to keep track of how much money I have coming in monthly
  As a user
  I want to be able to easily submit my monthly income

  @wip
  Scenario: I should be able to enter my income
    Given I am on my income page
    When I fill the amount as 12.00
    And submit as income
    Then I should see my monthly total as 12.00
