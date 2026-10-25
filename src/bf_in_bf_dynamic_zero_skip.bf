# MODULE dynamic logical tape with general zero valued loop skipping
# PURPOSE skip arbitrarily nested loop bodies when the current guest cell is zero
# INPUT one byte logical budget then commands terminated by a zero byte
# OUTPUT guest bytes followed by one development status byte
# TAPE twelve outer cells per right growing logical guest cell
# BEHAVIOR nonzero loops admit only the original exact clear patterns
# BEHAVIOR zero valued loops scan nested bracket syntax with checked depth
# LIMITATION no complete source preflight or verified host input closure
# LIMITATION depth greater than two hundred fifty five rejects as unsupported
# LIMITATION no guest fuel or general nonzero loop execution
# LIMITATION physical memory allocation failures are host dependent
# CONTRACT unknown or incomplete loop bodies terminate as unsupported

# Initialize origin sentinel and active interpreter loop
>>>>>>>>,<<<<<<<<>>>>>+>+<

# Interpret guest instructions with one lexical clear loop as a bounded fast path
[<<<<,>>>>[-]<<<<[

  # Retain active state and tentatively mark a nonzero opcode unsupported
  >>>>+<<<<
  >>>>>>>>+<<<<<<<<

  # Compare with addition opcode ASCII forty three
  [->+>+<<]>>[-<<+>>]<
  -------------------------------------------
  >+<[[-]>[-]<]>
  [[-]>>>>>>[-]<<<<<<<<<+>>>]
  <<

  # Compare with subtraction opcode ASCII forty five
  [->+>+<<]>>[-<<+>>]<
  ---------------------------------------------
  >+<[[-]>[-]<]>
  [[-]>>>>>>[-]<<<<<<<<<->>>]
  <<

  # Compare with output opcode ASCII forty six
  [->+>+<<]>>[-<<+>>]<
  ----------------------------------------------
  >+<[[-]>[-]<]>
  [[-]>>>>>>[-]<<<<<<<<<.>>>]
  <<

  # Compare with right movement opcode ASCII sixty two
  [->+>+<<]>>[-<<+>>]<
  --------------------------------------------------------------
  >+<[[-]>[-]<]>
  [[-]>>>>>>[-]<<<<<<>+<]
  <<

  # Compare with left movement opcode ASCII sixty
  [->+>+<<]>>[-<<+>>]<
  ------------------------------------------------------------
  >+<[[-]>[-]<]>
  [[-]>>>>>>[-]<<<<<<>>>>+<<<<]
  <<

  # Compare with opening bracket opcode ASCII ninety one
  [->+>+<<]>>[-<<+>>]<
  -------------------------------------------------------------------------------------------
  >+<[[-]>[-]<]>
# Handle zero valued loops with a bracket depth scanner
[[-]<<<>>[-]>[-]<<<[->>+>+<<<]>>>[-<<<+>>>]>[-]+<<[[-]>+>[-]<<]>>[[-]<<<<+[>,>[-]>[-]<<[->+>+<<]>>[-<<+>
>]<>>[-]+<<[[-]>>[-]<<]<<>>>>[[-]>>>>>>+<<<<<<<<<<[-]>>>>]<<[-]>[-]<<[->+>+<<]>>[-<<+>>]<---------------
---------------------------------------------------------------------------->>[-]+<<[[-]>>[-]<<]<<>>>>[[
-]<<<<+>>[-]>[-]<<<[->>+>+<<<]>>>[-<<<+>>>]<>>[-]+<<[[-]>>[-]<<]<<>>>>[[-]>>>>>>+<<<<<<]]<<[-]>[-]<<[->+
>+<<]>>[-<<+>>]<----------------------------------------------------------------------------------------
----->>[-]+<<[[-]>>[-]<<]<<>>>>[[-]<<<<->>>>]<<<<]>>>>[-]+<<[-]>[-]>>>>>>>[-<<<<<<<<+>+>>>>>>>]<<<<<<<[-
>>>>>>>+<<<<<<<]<[[-]>>[-]<<]>>[[-]>>>>>[-]<<<<<]>>>>>>[-]<<<<<<[-]]<[[-]<<<>,>,------------------------
--------------------------------------------------------------------->+<[[-]>[-]<]><<[->+>>+<<<]>[-<+>]<
------------------------------------------->+<[[-]>[-]<]>>>---------------------------------------------
>>>[-]+<<<[[-]>>>[-]<<<]>>>[-<<<<<+>>>>>]<<<<<[[-]>[[-]<<<[-]>>>>>>>>>[-]<<<<<<<<<>>>]<]<<>>>]]
  <<

  # Retire the original opcode so this dispatch ends only once
  [-]
]

# On unknown opcode preserve error status and stop this guest invocation
>>>>>>>>[[-]>>+++++++++++++<<<<<<[-]>>>>]<<<<<<<<

# An admitted left movement tests the origin sentinel before pointer travel
>>>>>>[
  <[->>>+>+<<<<]>>>[-<<<+>>>]>
  [ [-]<<<[-]<<[-]>>>>>>++++< ]
  <<<
  [[-]<<[-]<<<<<<<<<<<<+>>]
]

# Return to current record right movement flag
<<<

# Checked right movement also applies to programs using clearing loops
# A denied move clears the active flag and sets logical budget status five
[[-]
  >>>>
  >>>>>>>>>>>>[-]<<<<<<<<<<<<
  [->>>>>>>>>>>>+<<<<<<<<<<<<>>+<<]
  >>[-<<+<<<<<[-]+>>>>>>>]
  >+++++<<<<<<<<
  >>[-]<<
  [[-]
    >>>>>>>>[-]
    >>>>>>>>>-
    <<<<<>>+<<
  ]
  >
]
>

# The active token now identifies the selected guest record
]

# A single terminal status byte follows all diagnostic guest output
>>>>>>.

# END dynamic linear guest tape diagnostic
