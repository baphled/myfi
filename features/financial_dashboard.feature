Feature: Financial dashboard
  In order to see a summary of my finances
  As a user
  I want to be able to see a summary of my finances and relevant information

  @wip
  Scenario: I should be able to see how much I spend over X amount of time on a given item
    Given I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my Financial breakdown
    Then I should "13.00" for "Fast food"

  @wip
  Scenario: I should be able to see what I spend the most on
    Given I have a "120.50" for "Freelance" as "income" on "24th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my Financial breakdown
    Then I should see that I spent the most of "Fast food"

  @wip
  Scenario: I should be able to see what my main income is
    Given I have a "120.50" for "Freelance" as "income" on "24th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my Financial breakdown
    Then I should see that my main income is "Freelance"
