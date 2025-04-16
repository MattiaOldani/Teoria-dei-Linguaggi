from automata.pda.dpda import DPDA
from automata.pda.npda import NPDA


dpda = DPDA(
    states={""},
    input_symbols={""},
    stack_symbols={""},
    transitions={
        "": {
            "": {
                "": ("", ("")),
                "": ("", ("")),
            },
            "": {
                "": ("", ("")),
                "": ("", ("")),
            },
        },
    },
    initial_state="",
    initial_stack_symbol="",
    final_states={""},
    # empty_stack, final_state, both
    acceptance_mode="",
)

dpda.show_diagram(path="...")


npda = NPDA(
    states={""},
    input_symbols={""},
    stack_symbols={""},
    transitions={
        "": {
            "": {
                "": {("", (""))},
                "": {("", (""))},
            },
            "": {
                "": {("", (""))},
                "": {("", (""))},
            },
        },
    },
    initial_state="",
    initial_stack_symbol="",
    final_states={""},
    # empty_stack, final_state, both
    acceptance_mode="",
)

npda.show_diagram(path="...")
