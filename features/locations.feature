Feature: Location

  @poltergeist
  Scenario: As a user, when I reference the locations page, then I should see a map with markers for all previously set locations
    Given sample data has been loaded
    When I am logged on as "batman@cave.com"
      And I visit the "locations" page
    Then I should see markers appear
