Feature: Counter
  As an user
  I want to have a couple of counters
  In order to count between zero and given limit common for all counters


  Background:
    Given machine with
      """
        MAX=1 & NUM=2
      """
    And state machine "CounterSM:1"
    And class instance "Counters:1"


  Scenario: Intial value
    Then attribute "counter" is "0"
    And is in state "CounterSM_stopped"
    And is enabled transition 'start'
    And is disabled transition 'stop'
    And is disabled transition 'inc'
    And is disabled transition 'dec'


  Scenario: Start and stop
    Start the counter and stop it afterwards.

    When trigger transition 'start'
    Then is in state "CounterSM_started"
    And is disabled transition 'start'
    And is enabled transition 'stop'
    And is enabled method 'inc'
    And is disabled method 'dec'
    And is enabled method 'add' with "num = 1"
    But is disabled method 'add' with "num = 2"
    And is disabled method 'sub' with "num = 1"

    When trigger transition 'stop'
    Then is in state "CounterSM_stopped"
    And is enabled transition 'start'
    And is disabled transition 'stop'
    And is disabled method 'inc'
    And is disabled method 'dec'
    And is disabled method 'add' with "num = 1"
    And is disabled method 'sub' with "num = 1"


  Scenario: Increment
    Increment the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'inc'
    Then attribute "counter" is not "0"
    And is disabled transition 'inc'
    And is enabled transition 'dec'

    When trigger transition 'stop'
    Then attribute "counter" is not "0"
    And is disabled transition 'inc'
    And is disabled transition 'dec'


  Scenario: Decrement
    Decrement the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When trigger transition 'dec'
    Then attribute "counter" is "0"
    And is enabled transition 'inc'
    And is disabled transition 'dec'

    When trigger transition 'stop'
    Then attribute "counter" is "0"
    And is disabled transition 'inc'
    And is disabled transition 'dec'


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

