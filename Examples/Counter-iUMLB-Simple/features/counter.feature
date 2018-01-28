Feature: Counter
  As an user
  I want to have a counter
  In order to count between zero and the given limit


  Background:
    Given machine with "MAX = 1"
    And state machine "CounterSM"


  Scenario: Intial value
    Then formula "counter = 0" is TRUE
    And is in state "CounterSM_stopped"
    And transition 'start' is enabled
    And transition 'stop' is disabled
    And transition 'inc' is disabled
    And transition 'dec' is disabled


  Scenario: Start and stop
    Start the counter and stop it afterwards.

    When trigger transition 'start'
    Then is in state "CounterSM_started"
    And transition 'start' is disabled
    And transition 'stop' is enabled
    And transition 'inc' is enabled
    And transition 'dec' is disabled
    And transition 'add' with "num = 1" is enabled
    But transition 'add' with "num = 2" is disabled
    And transition 'sub' with "num = 1" is disabled

    When trigger transition 'stop'
    Then is in state "CounterSM_stopped"
    And transition 'start' is enabled
    And transition 'stop' is disabled
    And transition 'inc' is disabled
    And transition 'dec' is disabled
    And transition 'add' with "num = 1" is disabled
    And transition 'sub' with "num = 1" is disabled


  Scenario: Increment
    Increment the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'inc'
    Then formula "counter = 0" is FALSE
    And transition 'inc' is disabled
    And transition 'dec' is enabled

    When trigger transition 'stop'
    Then formula "counter = 0" is FALSE
    And transition 'inc' is disabled
    And transition 'dec' is disabled


  Scenario: Decrement
    Decrement the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When trigger transition 'dec'
    Then formula "counter = 0" is TRUE
    And transition 'inc' is enabled
    And transition 'dec' is disabled

    When trigger transition 'stop'
    Then formula "counter = 0" is TRUE
    And transition 'inc' is disabled
    And transition 'dec' is disabled


Scenario: Reset stopped
    Reset the stopped counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    And trigger transition 'stop'
    When fire event 'reset'
    Then is in state "CounterSM_stopped"
    And formula "counter = 0" is TRUE


Scenario: Reset started
    Reset the started counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When fire event 'reset'
    Then is in state "CounterSM_started"
    And formula "counter = 0" is TRUE


  Scenario: Add
    Add a value to the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'add' with "num = 1"
    And trigger transition 'stop'
    Then formula "counter = 0" is FALSE
    Then formula "counter = 1" is TRUE


  Scenario: Sub
    Subtract a value from the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When fire event 'sub' with "num = 1"
    And trigger transition 'stop'
    Then formula "counter = 0" is TRUE
