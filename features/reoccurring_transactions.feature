Feature: Reoccurring Transactions
  In order to track transactions that happen more than once over a period of time
  As a user
  I want to be able to create a transaction and specify its rate of reoccurrence

  Background:
    Given I am a registered user
    And I am signed in to my account

  Scenario Outline: I should be able to create a transaction that reoccurs bi-yearly
    Given I am on my new transaction page
    When I add my bi monthly "<type>" at "<amount>" as my "<transaction type>"
    Then I should see my monthly <transaction type> as "<amount>"

    When I visit my monthly outgoing next month
    Then I should see my monthly <transaction type> as "<next month>"

    When I visit my monthly outgoing in another months time
    Then I should see my monthly <transaction type> as "<2 months>"

  Examples:
      | transaction type | type       | amount | next month | 2 months |
      | outgoing         | Water Bill | 75.0   | 0.0        | 75.0     |
      | income           | Freelance  | 175.0  | 0.0        | 175.0    |

  Scenario Outline: I should be able to create a transaction that reoccurs quarterly
    Given I am on my new transaction page
    When I add my quarterly "<type>" at "<amount>" as my "<transaction type>"
    Then I should see my monthly <transaction type> as "<amount>"

    When I visit my monthly outgoing next month
    Then I should see my monthly <transaction type> as "<next month>"

    When I visit my monthly income in a total of 3 months
    Then I should see my monthly <transaction type> as "<3 months>"

  Examples:
      | transaction type | type       | amount | next month | 3 months |
      | outgoing         | Water Bill | 75.0   | 0.0        | 75.0     |
      | income           | Freelance  | 175.0  | 0.0        | 175.0    |

  Scenario Outline: I should be able to create a transaction that reoccurs x amount of months
    Given I am on my new transaction page
    When I add my <x month> "<type>" at "<amount>" as my "<transaction type>"
    Then I should see my monthly <transaction type> as "<amount>"

    When I visit my monthly outgoing next month
    Then I should see my monthly <transaction type> as "<next month>"

    When I visit my monthly income in a total of <x month> months
    Then I should see my monthly <transaction type> as "<custom months>"

  Examples:
      | x month | transaction type | type       | amount | next month | custom months |
      | 7       | outgoing         | Water Bill | 75.0   | 0.0        | 75.0          |
      | 6       | outgoing         | Water Bill | 75.0   | 0.0        | 75.0          |
      | 3       | income           | Freelance  | 175.0  | 0.0        | 175.0         |
      | 8       | income           | Freelance  | 175.0  | 0.0        | 175.0         |
      | 12      | income           | Freelance  | 175.0  | 0.0        | 175.0         |

  Scenario Outline: I should still see my transaction after the first reoccurrence
    Given I am on my new transaction page
    When I add my <reoccurring months> "<type>" at "<amount>" as my "<transaction type>"
    Then I should see my monthly <transaction type> as "<amount>"

    When I visit my monthly outgoing next month
    Then I should see my monthly <transaction type> as "<next month>"

    Given it is <total number of> months later
    When I visit my monthly income
    And all tranfers have their next occurring transaction updated
    And I visit my monthly income
    Then I should see my monthly <transaction type> as "<amount after total months>"

  Examples:
      | reoccurring months | total number of | transaction type | type       | amount | next month | amount after total months |
      | 3                  | 6               | income           | Freelance  | 175.0  | 0.0        | 175.0                     |
      | 6                  | 12              | outgoing         | Water Bill | 75.0   | 0.0        | 75.0                      |
      | 12                 | 24              | income           | Freelance  | 175.0  | 0.0        | 175.0                     |
