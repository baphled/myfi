Feature: Update alerts
  I need to be alerted that I should update the daily in and out goings
  As a user
  I want a feature that can remind me to keep my daily transactions up to date

  Background:
    Given I am a registered user
    And I am signed in to my account

  @wip
  Scenario: I should be able to set my account to give me daily email reminders
    Given I am on my account settings page
    When I check "Daily updates"
    And I set the update time to "13:00"
    Given it is "12:59" today
    And I wait 1 minute
    Then I should receive an update via email
