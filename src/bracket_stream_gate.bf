# MODULE streaming bracket depth validator
# PURPOSE preserve nested BF bracket state across input chunks
# INPUT repeated count data guard records followed by zero count and guard
# OUTPUT one byte one for valid structure or zero for rejection
# TAPE cell zero remaining count in active data record
# TAPE cell one source byte or guard
# TAPE cell two character comparison scratch
# TAPE cell three comparison restoration scratch
# TAPE cell four opening bracket flag
# TAPE cell five closing bracket flag
# TAPE cell six nesting depth
# TAPE cell seven sticky rejection flag
# TAPE cell eight nested depth copy
# TAPE cell nine depth restoration helper
# TAPE cell ten zero depth and overflow scratch
# TAPE cell eleven final Boolean output
# TAPE cell twelve active stream record flag
# TAPE cell thirteen count restoration scratch
# PRECONDITION only lexically normalized original BF command bytes
# PRECONDITION trusted exact bytes and host closure before acceptance
# LIMITATION independent literal input trailer does not attest host closure
# BUDGET each record holds at most 255 source commands
# BUDGET nested depth above 255 rejects rather than wrapping silently

# Initially allow reading another source record
>>>>>>>>>>>>+
[
  [-]
  <<<<<<<<<<<<,

  # Preserve the count and indicate another record when count is nonzero
  [->>>>>>>>>>>>+>+<<<<<<<<<<<<<]
  >>>>>>>>>>>>>[<<<<<<<<<<<<<+>>>>>>>>>>>>>-]
  <<<<<<<<<<<<<

  # Consume every byte in this complete data record
  [
    -
    >,

    # Opening bracket equality and checked nesting depth increment
    [->+>+<<]>>[<<+>>-]<<
    >
    >+++++++++++++[<------->-]<
    >>+<<[->>[-]<<]>>
    [>>+>>>>+<<<<<<-]

    # Check for wrapping from nesting depth 255 to zero
    >>>>>>
    [
      -<<<<
      [->>+>+<<<]>>>[<<<+>>>-]<
      >>+<<[[-]>>[-]<<]
      >>[<<<[-]+>>>-]
    ]
    <<<<<<<<<

    # Closing bracket equality and underflow check
    [->+>+<<]>>[<<+>>-]<<
    >
    >+++++++++++++[<------->-]<--
    >>>+<<<[->>>[-]<<<]>>>
    [
      >[->>+>+<<<]>>>[<<<+>>>-]<
      >+<
      [[-]>[-]>+<<]
      >[<<[-]+>>-]
      >[<<<<->>>>-]
      <<<<<-
    ]
    <<<<
    <
  ]

  # Verify the mandatory guard of this record including the final record
  >,
  >+++++++++++[<--------------->-]<
  [->>>>>>[-]+<<<<<<]

  # Continue for positive count and stop at the zero length terminal record
  >>>>>>>>>>>
]

# No acceptance until the terminal record has been fully checked
<<<<<
>>>>+
<<<<[->>>>[-]<<<<]
<[->>>>>[-]<<<<<]
>>>>>.

# END streaming bracket validation
