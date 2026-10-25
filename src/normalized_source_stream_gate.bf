# MODULE normalized command and bracket streaming admission
# PURPOSE reject every noncommand byte and unmatched bracket in a bounded stream
# INPUT repeated nonzero record count and literal bytes and A5 guard
# INPUT terminal zero count and mandatory A5 guard
# OUTPUT one if accepted or zero if rejected
# TAPE cells zero through thirteen follow the original bracket stream layout
# TAPE cell fourteen sticky recognized command flag for current byte
# TAPE cell fifteen scratch flag for command membership rejection
# CONTRACT only original eight BF commands admitted in record payloads
# CONTRACT successful admission is provisional until trusted host closure
# BUDGET per record length at most 255 and bracket depth at most 255
# LIMITATION does not parse annotated source lines or verify host closure
# LIMITATION separate source offset diagnostics are not implemented

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

    # Compare source byte with ASCII addition
    [->+>+<<]>>[<<+>>-]<
    -------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII subtraction
    [->+>+<<]>>[<<+>>-]<
    ---------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII left pointer command
    [->+>+<<]>>[<<+>>-]<
    ------------------------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII right pointer command
    [->+>+<<]>>[<<+>>-]<
    --------------------------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII loop opening command
    [->+>+<<]>>[<<+>>-]<
    -------------------------------------------------------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII loop closing command
    [->+>+<<]>>[<<+>>-]<
    ---------------------------------------------------------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII output command
    [->+>+<<]>>[<<+>>-]<
    ----------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Compare source byte with ASCII input command
    [->+>+<<]>>[<<+>>-]<
    --------------------------------------------
    >>+<<[->>[-]<<]>>[->>>>>>>>>>+<<<<<<<<<<]<<<

    # Reject if no comparison recognized the original command
    >>>>>>>>>>>>>
    >+<[->[-]<]>[<<<<<<<<+>>>>>>>>-]<<<<<<<<<<<<<<


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

# END normalized source admission
