# MODULE bracket depth gate
# PURPOSE validate matching loop brackets in normalized BF source bytes
# INPUT one byte count then that many source bytes then guard byte A5
# OUTPUT one byte boolean with one for valid bracket structure
# TAPE cell zero remaining input count
# TAPE cell one current source byte and then trailer
# TAPE cell two equality test scratch
# TAPE cell three restoration scratch
# TAPE cell four opening bracket match flag
# TAPE cell five closing bracket match flag
# TAPE cell six nesting depth
# TAPE cell seven rejection accumulator
# TAPE cell eight temporary depth copy
# TAPE cell nine restoration scratch
# TAPE cell ten nonzero depth flag
# TAPE cell eleven final boolean output
# PRECONDITION exact lexical admission of eight command bytes
# PRECONDITION independently verified input byte count and closure
# BUDGET one byte per invocation source count with no global source cap
# LIMITATION not complete source admission and no original byte offsets

# Read declared source length and visit each byte before reporting success
,[
  -
  >,

  # Preserve original byte while comparing against opening bracket
  [->+>+<<]>>[<<+>>-]<<
  >
  >+++++++++++++[<------->-]<
  >>+<<[->>[-]<<]>>
  [>>+<<-]
  <<<

  # Preserve original byte while comparing against closing bracket
  [->+>+<<]>>[<<+>>-]<<
  >
  >+++++++++++++[<------->-]<--
  >>>+<<<[->>>[-]<<<]>>>
  [
    # Copy nesting depth without changing the original depth
    >[->>+>+<<<]>>>[<<<+>>>-]<

    # Preserve earlier errors and classify zero versus nonzero depth
    >+<
    [[-]>[-]>+<<]

    # An unmatched closing bracket sets a sticky rejection flag
    >[<<[-]+>>-]

    # Otherwise consume exactly one previously opened bracket
    >[<<<<->>>>-]
    <<<<<-
  ]
  <<<<
  <
]

# Check the declared nonzero completion guard exactly
>,
>+++++++++++[<--------------->-]<
[->>>>>>[-]+<<<<<<]

# An earlier closing bracket or bad trailer vetoes acceptance
>>>>>>
>>>>+
<<<<[->>>>[-]<<<<]

# Remaining opening brackets veto acceptance as well
<[->>>>>[-]<<<<<]
>>>>>.

# END bracket gate
