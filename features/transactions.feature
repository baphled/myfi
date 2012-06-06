Feature: Transactions
  In order to keep track of how much money I have coming in
  As a user
  I want to be able to easily submit my month going in and out

  Scenario: I should be able to enter my income
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.0"
    And submit as income
    Then I should see my monthly income as "2200.0"

  Scenario: I should be able to add more than one income
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And submit as income
    And I fill in type as "Freelance"
    When I fill the amount as "1200.00"
    And submit as income
    Then I should see my monthly income as "3400.0"

  Scenario: I should be able to add an money going out
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And submit as outgoing
    Then I should see my monthly outgoing as "2200.0"

  Scenario: I should be able to see my in/outcome
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And submit as income
    And I fill in type as "Freelance"
    When I fill the amount as "1200.0"
    And submit as outgoing
    Then I should see my monthly outgoing as "1200.0"
    Then I should see my monthly income as "2200.0"

  Scenario: I should not be able to see a transaction that was created a month ago
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And submit as income
    Then I should see my monthly income as "2200.0"
    When I visit my monthly income next month
    Then I should see my monthly income as "0.0"

  Scenario: I should be able to set when the transaction is made
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And I fill in "created at" as next month
    And submit as income
    Then I should see my monthly income as "0.0"

  @wip
  Scenario: I should be able to set a transaction as reoccuring
    Given I am on my new transaction page
    And I fill in type as "Salary"
    When I fill the amount as "2200.00"
    And I check it as "reoccuring"
    And submit as income
    When I visit my monthly income next month
    Then I should see my monthly income as "2200.0"

  Scenario: I should be able to see my monthly total
