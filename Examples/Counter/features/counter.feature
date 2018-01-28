Feature: Counter
  As an user
  I want to have a counter
  In order to count between zero and the given limit


  Background:
    Given machine with "MAX = 1"


  Scenario: Intial value
    Then formula "counter = 0" is TRUE
    And event 'inc' is enabled
    And event 'dec' is disabled
    And event 'add' with "num = 1" is enabled
    But event 'add' with "num = 2" is disabled
    And event 'sub' with "num = 1" is disabled


  Scenario: Increment
    Increment the counter. Use domain specific steps.

    When increment the counter
    Then the counter is not zero
    And the counter can not increment
    And the counter can decrement


  Scenario: Decrement
    Decrement the counter. Use domain specific steps.

    Given increment the counter
    When decrement the counter
    Then the counter is zero
    And the counter can increment
    And the counter can not decrement


  Scenario: Reset
    Reset the counter. Use domain specific steps.

    Given increment the counter
    When reset the counter
    Then the counter is zero
    And the counter can increment
    And the counter can not decrement


  Scenario: Add
    Add a value to the counter.

    When fire event 'add' with "num = 1"
    Then formula "counter = 0" is FALSE
    And formula "counter = 1" is TRUE
    And event 'add' with "num = 1" is disabled
    And event 'sub' with "num = 1" is enabled
    But event 'sub' with "num = 2" is disabled


  Scenario: Sub
    Subtract a value from the counter.

    Given fire event 'inc'
    When fire event 'sub' with "num = 1"
    Then formula "counter = 0" is TRUE
    And event 'add' with "num = 1" is enabled
    But event 'add' with "num = 2" is disabled
    And event 'sub' with "num = 1" is disabled
