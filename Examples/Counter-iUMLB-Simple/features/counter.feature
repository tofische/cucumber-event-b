Feature: Counter
  As an user
  I want to have a counter
  In order to count between zero and the given limit


  Background:
    Given machine with "MAX = 1"
    And state machine "CounterSM"


  Scenario: Intial value
    Then is TRUE formula "counter = 0"
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
    And is enabled transition 'inc'
    And is disabled transition 'dec'
    And is enabled transition 'add' with "num = 1"
    But is disabled transition 'add' with "num = 2"
    And is disabled transition 'sub' with "num = 1"

    When trigger transition 'stop'
    Then is in state "CounterSM_stopped"
    And is enabled transition 'start'
    And is disabled transition 'stop'
    And is disabled transition 'inc'
    And is disabled transition 'dec'
    And is disabled transition 'add' with "num = 1"
    And is disabled transition 'sub' with "num = 1"


  Scenario: Increment
    Increment the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'inc'
    Then is FALSE formula "counter = 0"
    And is disabled transition 'inc'
    And is enabled transition 'dec'

    When trigger transition 'stop'
    Then is FALSE formula "counter = 0"
    And is disabled transition 'inc'
    And is disabled transition 'dec'


  Scenario: Decrement
    Decrement the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When trigger transition 'dec'
    Then is TRUE formula "counter = 0"
    And is enabled transition 'inc'
    And is disabled transition 'dec'

    When trigger transition 'stop'
    Then is TRUE formula "counter = 0"
    And is disabled transition 'inc'
    And is disabled transition 'dec'


Scenario: Reset stopped
    Reset the stopped counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    And trigger transition 'stop'
    When fire event 'reset'
    Then is in state "CounterSM_stopped"
    And is TRUE formula "counter = 0"


Scenario: Reset started
    Reset the started counter. The counter shall preserve its state.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When fire event 'reset'
    Then is in state "CounterSM_started"
    And is TRUE formula "counter = 0"


  Scenario: Add
    Add a value to the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    When trigger transition 'add' with "num = 1"
    And trigger transition 'stop'
    Then is FALSE formula "counter = 0"
    Then is TRUE formula "counter = 1"


  Scenario: Sub
    Subtract a value from the counter and stop it afterwards. The counter shall preserve its value.

    Given trigger transition 'start'
    And trigger transition 'inc'
    When fire event 'sub' with "num = 1"
    And trigger transition 'stop'
    Then is TRUE formula "counter = 0"

