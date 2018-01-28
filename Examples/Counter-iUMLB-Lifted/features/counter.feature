Feature: Counter
  As an user
  I want to have a couple of counters
  In order to count between zero and given limit common for all counters

  Background:
    Given machine with "MAX = 1 & NUM = 2"
    And state machine "CounterSM:1"
    And class "Counters:1"


  Scenario: Intial value
    Then attribute "counter" is "0"
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
    And method 'inc' is enabled
    And method 'dec' is disabled
    And method 'add' with "num = 1" is enabled
    But method 'add' with "num = 2" is disabled
    And method 'sub' with "num = 1" is disabled

    When trigger transition 'stop'
    Then is in state "CounterSM_stopped"
    And transition 'start' is enabled
    And transition 'stop' is disabled
    And method 'inc' is disabled
    And method 'dec' is disabled
    And method 'add' with "num = 1" is disabled
    And method 'sub' with "num = 1" is disabled


  Scenario: Increment
    Increment the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'inc'
    Then attribute "counter" is not "0"
    And transition 'inc' is disabled
    And transition 'dec' is enabled

    When trigger transition 'stop'
    Then attribute "counter" is not "0"
    And transition 'inc' is disabled
    And transition 'dec' is disabled


  Scenario: Decrement
    Decrement the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When trigger transition 'dec'
    Then attribute "counter" is "0"
    And transition 'inc' is enabled
    And transition 'dec' is disabled

    When trigger transition 'stop'
    Then attribute "counter" is "0"
    And transition 'inc' is disabled
    And transition 'dec' is disabled


  Scenario: Reset stopped
    Reset the stopped counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    And trigger transition 'stop'
    When call method 'reset'
    Then is in state "CounterSM_stopped"
    And attribute "counter" is "0"


  Scenario: Reset started
    Reset the started counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When call method 'reset'
    Then is in state "CounterSM_started"
    And attribute "counter" is "0"


  Scenario: Add
    Add a value to the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When call method 'add' with "num = 1"
    And trigger transition 'stop'
    Then attribute "counter" is not "0"
    Then attribute "counter" is "1"


  Scenario: Sub
    Subtract a value from the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When call method 'sub' with "num = 1"
    And trigger transition 'stop'
    Then attribute "counter" is "0"
