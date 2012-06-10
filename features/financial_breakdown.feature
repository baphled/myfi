Feature: Financial breakdown
  As a user
  I want to be able to see a breakdown of my finances
  
  Background:
    Given I am a registered user
    And I am signed in to my account

  Scenario: I should be able to see a transactional breakdown for the month
    Given it is 2 weeks into the month
    When I have a "outgoing" of "6.50" as my "Burrito Bros" 2 days ago
    And I have a "outgoing" of "6.50" as my "Burrito Bros" 7 days ago
    And I have a "income" of "120.50" as my "Freelance" 7 days ago
    And I visit my Financial breakdown
    Then I should 2 "outgoing" entries
    And I should 1 "income" entry
