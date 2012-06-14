Feature: Manage my transactional accounts
  In order to easily manage my finances over a number of accounts
  As a user
  I want to be able to manage multiple account and their transactions

  @wip
  Scenario: I should be able to see a list of account I can create
    Given I am on the new accounts page
    Then I should see the following:
      | bank account    |
      | credit card     |
      | savings account |

  @wip
  Scenario Outline: creating basic accounts
    Given I am on the new accounts page
    When I select a <account type>
    And I fill in my account details
    Then I should see the flash message "You have successfully created <account type>"

  Examples: basic accounts
      | bank account    |
      | savings account |

  @wip
  Scenario: Credit card account need a credit limit
    Given I am on the new accounts page
    When I select a credit card account
    And I fill in my account details
    Then I should see the flash message "You need to add a credit limit"

  @wip
  Scenario: Credit card account must have interest rates
    Given I am on the new accounts page
    When I select a "credit card" account
    And I fill in my credit card account details without my APR
    Then I should see the flash message "You need to add your APR"

  @wip
  Scenario: I should be able to create a transaction account
    Given I am on the new accounts page
    When I successfully create a new account
    Then I should see the flash message "Successfully created a new account"

  @wip
  Scenario: A new transaction must be made on an account
    Given I am on my new transaction page
    When I fill in "Type" with "Salary"
    And I fill in "Amount" with "13.0"
    And I press "Income"
    Then I should see the validation error "Must assign a transaction to an account"
