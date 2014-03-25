Feature: Testing Search List functionality

  Scenario: Press By Name button
    Given I reset iphone simulator launch application
    When I press on "By Name"

  Scenario: Print in terminal available searches
    Given I reset iphone simulator launch application
    Then I will print in terminal available searches

  Scenario: Delete searches from list
    Given I reset iphone simulator launch application
    When I press on "Edit"
    And I will delete "coffee" from list
    Then searches list should not include "coffee"

  Scenario: Add additional searches to list
    Given I reset iphone simulator launch application
    When I press on "Add"
    Then I add "fish tacos" as a New Search criteria
    Then searches list should include "fish tacos"

  Scenario: Suppress current location
    Given I supress current location service

  Scenario: Fake search returns correct module dialog
    Given I supress current location service
    Given I reset iphone simulator launch application
    When I press on "Add"
    Then I add "qwert" as a New Search criteria
    When I press on "qwert"
    Then I should see module dialog with title "Not found"

  Scenario: results is not visible in the list
    Given I supress current location service
    Given I reset iphone simulator launch application
    When I press on "coffee"
    When I press on "List"
    Then all items in list should be visible

  Scenario: Application shows correct module dialog when connection dropped
    Given I supress current location service
    Given I reset iphone simulator launch application
    Given I turn off my WIFI
    When I press on "coffee"
    Then I should see module dialog with title "Network Error"
    Given I turn on my WIFI

#homework
#  Scenario: Verify that header match with search criteria
