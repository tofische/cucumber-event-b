import cucumber.api.*
import static cucumber.api.groovy.EN.*
import static cucumber.api.groovy.Hooks.*


Given(~/^the counter can increment$/) { ->
    isEventEnabled("inc")
}

Given(~/^the counter can not increment$/) { ->
    isEventDisabled("inc")
}

Given(~/^the counter can decrement$/) { ->
    isEventEnabled("dec")
}

Given(~/^the counter can not decrement$/) { ->
    isEventDisabled("dec")
}

When(~/^reset the counter$/) { ->
    fireEvent("reset")
}

When(~/^increment the counter$/) { ->
    fireEvent("inc")
}

When(~/^decrement the counter$/) { ->
    fireEvent("dec")
}

Then(~/^the counter is zero$/) { ->
    isFormula("counter = 0", "TRUE")
}

Then(~/^the counter is not zero$/) { ->
    isFormula("counter = 0", "FALSE")
}
