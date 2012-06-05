Feature: I want to be able to add my monthly income
  In order to keep track of how much money I have coming in monthly
  As a user
  I want to be able to easily submit my monthly income

  @wip
  Scenario: I should be able to enter my income
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And submit as income
    Then I should see my monthly total as "2200.00"

  @wip
  Scenario: I should be able to add more than one income
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And I fill in type as "Freelance"
    When I fill the amount as "1200.00"
    And submit as income
    Then I should see my monthly total as "3400.00"
