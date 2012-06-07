Feature: Financial breakdown
  As a user
  I want to be able to see a breakdown of my finances
  
  Scenario: I should be able to see a transactional breakdown for the month
    Given it is 2 weeks into the month
    When I have a "outgoing" of "6.50" as my "Burrito Bros" 2 days ago
    When I have a "outgoing" of "6.50" as my "Burrito Bros" 7 days ago
    When I have a "income" of "120.50" as my "Freelance" 7 days ago
    When I visit my Financial breakdown
    Then I should 2 "outgoing" entries
    And I should 1 "income" entry

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
