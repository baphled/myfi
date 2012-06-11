Feature: Managing my user account
  In order to manage my Financial needs
  As a user
  I need to be able to create an account and manage it

  Scenario: I should be able to create a new account
    Given I am on the signup page
    When I successfully fill in the signup form
    Then my account should be created
    And I should see the flash message "Successfully created account"

  Scenario: I should be able to signin
    Given I am a registered user
    And I am on the login page
    And I fill in "Email" with "y@me.com"
    And I fill in "Password" with "password"
    When I press "Signin"
    Then I should see the flash message "Successfully signed in"

  Scenario: I should be able to sign out
    Given I am a registered user
    And I am signed in to my account
    When I sign out
    Then I should see the flash message "Successfully signed out"

  Scenario: I should stay logged in
    Given I am a registered user
    And I am signed in to my account
    When I am on my new transaction page
    Then I should still be signed in
