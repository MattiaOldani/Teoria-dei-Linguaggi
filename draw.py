from visual_automata.fa.dfa import VisualDFA
from visual_automata.fa.nfa import VisualNFA


dfa = VisualDFA(
    states={""},
    input_symbols={""},
    transitions={
        "": {"": "", "": ""},
    },
    initial_state="",
    final_states={""},
)

dfa.show_diagram(view=True, format_type="svg", filename="...")


nfa = VisualNFA(
    states={""},
    input_symbols={""},
    transitions={
        "": {"": {""}, "": {""}},
    },
    initial_state="",
    final_states={""},
)

nfa.show_diagram(view=True, format_type="svg", filename="...")
