Feature: Counter
  As an user
  I want to have a counter
  In order to count between zero and the given limit


  Background:
    Given machine with "MAX = 1"


  Scenario: Intial value
    Then is TRUE formula "counter = 0"
    And is enabled event 'inc'
    And is disabled event 'dec'
    And is enabled event 'add' with "num = 1"
    But is disabled event 'add' with "num = 2"
    And is disabled event 'sub' with "num = 1"


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
    Then is FALSE formula "counter = 0"
    And is TRUE formula "counter = 1"
    And is disabled event 'add' with "num = 1"
    And is enabled event 'sub' with "num = 1"
    But is disabled event 'sub' with "num = 2"


  Scenario: Sub
    Subtract a value from the counter.

    Given fire event 'inc'
    When fire event 'sub' with "num = 1"
    Then is TRUE formula "counter = 0"
    And is enabled event 'add' with "num = 1"
    But is disabled event 'add' with "num = 2"
    And is disabled event 'sub' with "num = 1"

