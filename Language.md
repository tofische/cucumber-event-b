Language description
====================
Your features may use the following step definitions (you may choose to use single or double quotes).
The logic of the particular step is also available as a method for the composition in the domain specific steps.

Event-B
--------------------
* `Given machine`

  `Given machine with "«Formula»"`

  `Given machine with`\
  `| name | value |`

  Setup constants (optionally with the given constants constraints) and initialize the machine.

  Available as _`setupConstantsInitialiseMachine(String formula)`_ method (parameter `formula` is optional).

* `When fire event "«Event-Name»"`

  `When fire event "«Event-Name»" with "«Formula»"`

  Fire the given event (optionally with the given parameters constraints).

  Available as _`fireEvent(String eventName, String formula)`_ method (parameter `formula` is optional).

* `Then event "«Event-Name»" is enabled`

  `Then event "«Event-Name»" with "«Formula»" is enabled`

  Check if the given event (optionally with the given parameters constraints) is enabled.

  Available as _`isEventEnabled(String eventName, String formula)`_ method (parameter `formula` is optional).

* `Then event "«Event-Name»" is disabled`

  `Then event "«Event-Name»" with "«Formula»" is disabled`

  Check if the given event (optionally with the given parameters constraints) is disabled.

  Available as _`isEventDisabled(String eventName, String formula)`_ method (parameter `formula` is optional).

* `Then formula "«Formula»" is TRUE`

  `Then formula "«Formula»" is FALSE`

  Check if the given formula evaluates to the given value.

  Available as _`isFormula(String formula, String value)`_ method.


iUML-B State Machines (both enumeration and variables translation)
--------------------

The state machine identification is either the plain state machine name (e.g. `StateMachine`) or for the lifted state machine the state machine name followed by the instance, separated by the colon (e.g. `StateMachine:Instance`).

* `Given state machine "«State-Machine»"`
  Preset the given state machine for subsequent steps.

* `When trigger transition "«Trans-Name»"`

  `When trigger transition "«Trans-Name»" with "«Formula»"`

  `When trigger transition "«Trans-Name»" for state machine "«State-Machine»"`

  `When trigger transition "«Trans-Name»" with "«Formula»" for state machine "«State-Machine»"`

  Trigger the given transition (optionally with the given parameters constraints) of the preset or given state machine.

  Available as _`triggerTransition(String transName, String smId, String formula)`_ method (parameters `smId` and `formula` are optional).

* `Then transition "«Trans-Name»" is enabled`

  `Then transition "«Trans-Name»" with "«Formula»" is enabled`

  `Then transition "«Trans-Name»" is enabled for state machine "«State-Machine»"`

  `Then transition "«Trans-Name»" with "«Formula»" is enabled for state machine "«State-Machine»"`

  Check, if the given transition (optionally with the given parameters constraints) of the preset or given state machine is enabled.

  Available as _`isTransitionEnabled(String transName, String smId, String formula)`_ method (parameters `smId` and `formula` are optional).

* `Then transition "«Trans-Name»" is disabled`

  `Then transition "«Trans-Name»" with "«Formula»" is disabled`

  `Then transition "«Trans-Name»" is disabled for state machine "«State-Machine»"`

  `Then transition "«Trans-Name»" with "«Formula»" is disabled for state machine "«State-Machine»"`

  Check, if the given transition (optionally with the given parameters constraints) of the preset or given state machine is disabled.

  Available as _`isTransitionDisabled(String transName, String smId, String formula)`_ method (parameters `smId` and `formula` are optional).

* `Then is in state "«State»"`

  `Then is not in state "«State»"`

  `Then state machine "«State-Machine»" is in state "«State»"`

  `Then state machine "«State-Machine»" is not in state "«State»"`

  Check, if the preset or given state machine is or is not in the given state.

  Available as _`isInState(String smId, String state, boolean not)`_ method (parameters `smId` and `not` are optional).


iUML-B Class Diagrams
--------------------

The class instance identification is the class name followed by the instance, separated by the colon (e.g. `ClassName:Instance`).

* `Given class instance "«Class»"`

  Preset the given class instance for subsequent steps.

* `When call method "«Method-Name»"`

  `When call method "«Method-Name»" with "«Formula»"`

  `When call method "«Method-Name»" for class instance "«Class»"`

  `When call method "«Method-Name»" with "«Formula»" for class instance "«Class»"`

  Call the given method (optionally with the given parameters constraints) of the preset or given classs instance.

  Available as _`callMethod(methodName, classId, formula)`_ method (parameters `classId` and `formula` are optional).

* `Then method "«Method-Name»" is enabled`

  `Then method "«Method-Name»" with "«Formula»" is enabled`

  `Then method "«Method-Name»" is enabled for class instance "«Class»"`

  `Then method "«Method-Name»" with "«Formula»" is enabled for class instance "«Class»"`

  Check, if the given method (optionally with the given parameters constraints) of the preset or given classs instance is enabled.

  Available as _`isMethodEnabled(methodName, classId, formula)`_ method (parameters `classId` and `formula` are optional).

* `Then method "«Method-Name»" is disabled`

  `Then method "«Method-Name»" with "«Formula»" is disabled`

  `Then method "«Method-Name»" is disabled for class instance "«Class»"`

  `Then method "«Method-Name»" with "«Formula»" is disabled for class instance "«Class»"`

  Check, if the given method (optionally with the given parameters constraints) of the preset or given classs instance is disabled.

  Available as _`isMethodDisabled(methodName, classId, formula)`_ method (parameters `classId` and `formula` are optional).

* `Then attribute "«Attr-Name»" is "«Value»"`

  `Then attribute "«Attr-Name»" is not "«Value»"`

  `Then attribute "«Attr-Name»" of class instance "«Class»" is "«Value»"`

  `Then attribute "«Attr-Name»" of class instance "«Class»" is not "«Value»"`

  Check, if the given attribute of the preset or given class instance has or has not the given value.

  Available as _`isAttribute(String classId, String attrName, String value, boolean not)`_ method (parameters `classId` and `not` are optional).

Restrictions
====================
* Only class diagrams within Event-B machines (not within Event-B contexts) are considered
* An association can be referenced as an attribute.
* A lifted state machine and a corresponding class must have the same self names.
