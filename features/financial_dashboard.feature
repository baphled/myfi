Feature: Financial dashboard
  In order to see a summary of my finances
  As a user
  I want to be able to see a summary of my finances and relevant information

  Background:
    Given I am a registered user
    And I am signed in to my account

  Scenario: I should be able to see how much I spend over X amount of time on a given item
    Given I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my dashboard
    Then I should "13.0" for "Fast food"

  Scenario: I should be able to see what I spend the most on
    Given I have a "120.50" for "Freelance" as "income" on "24th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my dashboard
    Then I should see that I spent the most of "Fast food"

  Scenario: I should be able to see what my main income is
    Given I have a "120.50" for "Freelance" as "income" on "24th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "7th" of this month
    And I have a "6.50" for "Fast food" as "outgoing" on "17th" of this month
    When I visit my dashboard
    Then I should see that my main income is "Freelance"
