Feature: Transactions
  In order to keep track of how much money I have coming in
  As a user
  I want to be able to easily submit my month going in and out

  Background:
    Given I am a registered user
    And I am signed in to my account

  Scenario: I should be able to enter my income
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income"
    Then I should see my monthly income as "2200.0"

  Scenario: I should be able to add more than one income
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income"
    And I add my "Freelance" at "1200.00" as my "income"
    Then I should see my monthly income as "3400.0"

  Scenario: I should be able to add an money going out
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "outgoing"
    Then I should see my monthly outgoing as "2200.0"

  Scenario: I should be able to see my in/outcome
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income"
    And I add my "Outsourcing" at "1200.00" as my "outgoing"
    Then I should see my monthly outgoing as "1200.0"
    And I should see my monthly income as "2200.0"

  Scenario: I should not be able to see a transaction that was created a month ago
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income"
    Then I should see my monthly income as "2200.0"
    When I visit my monthly income next month
    Then I should see my monthly income as "0.0"

  Scenario: I should be able to set when the transaction is made
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income" for next month
    Then I should see my monthly income as "0.0"

  Scenario: I should be able to see my monthly total
    Given I am on my new transaction page
    When I add my "Salary" at "2200.00" as my "income"
    And I add my "Outsourcing" at "1200.00" as my "outgoing"
    Then I should see my monthly total as "1000.0"

  Scenario: I should be able to set a transaction as reoccurring
    Given I am on my new transaction page
    When I add a reoccurring "income" of "2200.00" as my "Salary" from today to 6 months
    When I visit my monthly income in 6 months
    Then I should see my monthly income as "2200.0"

  Scenario: I should be able to set an outgoing transaction as reoccurring
    Given I am on my new transaction page
    When I add a reoccurring "outgoing" of "45.00" as my "Water" from today to 6 months
    When I visit my monthly income in 6 months
    Then I should see my monthly outgoing as "45.0"

  Scenario: I should be able to delete an income entry
    Given I have a "2447.50" for "Salary" as "income" on "7th" of this month
    When I view the last create income entry
    And I choose to remove the item
    Then I should see the flash message "Successfully removed income entry"

  Scenario: I should be able to delete an outgoing entry
    Given I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    When I view the last create outgoing entry
    And I choose to remove the item
    Then I should see the flash message "Successfully removed outgoing entry"

  @wip
  Scenario: I should be able to create a transaction that reoccurs bi-yearly
    Given I am on my new transaction page
    And I have filled in "Type" with "Water bill"
    And I have filled in "Amount" with "75.0"
    And I click "Reoccurring"
    And I click "bi-monthly"
    And the transaction starts today
    Then I should see my monthly outgoing as "75.0"

    When I visit my monthly outgoing next month
    Then I should see my monthly outgoing as "0.0"

    When I visit my monthly outgoing in 5 months time
    Then I should see my monthly outgoing as "75.0"

  @wip
  Scenario: I should be able to create a transaction that reoccurs quarterly
    Given I am on my new transaction page
    And I have filled in "Type" with "Water bill"
    And I have filled in "Amount" with "75.0"
    And I click "Reoccurring"
    And I click "bi-monthly"
    And the transaction starts today
    Then I should see my monthly outgoing as "75.0"

    When I visit my monthly outgoing next month
    Then I should see my monthly outgoing as "0.0"

    When I visit my monthly outgoing in 2 months time
    Then I should see my monthly outgoing as "75.0"

  @wip
  Scenario: I should be able to create a transaction that reoccurs x amount of months
