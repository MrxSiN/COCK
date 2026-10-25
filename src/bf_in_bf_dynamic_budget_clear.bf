# MODULE COCK dynamic tape interpreter with checked logical budget and clear loops
# PURPOSE execute bounded guest arithmetic pointer travel and clear loop patterns
# INPUT one budget byte equal to the maximum additional logical cells
# INPUT then admitted raw guest commands and a zero terminator
# INPUT host byte count and successful stream closure are external prerequisites
# OUTPUT guest bytes followed by one terminal status byte
# TAPE every twelve outer cells represent one logical guest cell
# TAPE first cell is guest value and second is current input opcode
# TAPE third cell is comparison scratch and fourth is matching flag
# TAPE fifth cell records right travel and sixth stores execution control
# TAPE seventh marks logical guest address zero and eighth records left travel
# TAPE ninth cell carries remaining logical address budget
# TAPE tenth is invalid command marker and twelfth is terminal result
# PROFILE arithmetic wraps at eight bits and new guest cells start at zero
# PROFILE guest source admits arithmetic pointer movement output and exact clear loops
# LIMITATION budget supports one through two hundred fifty six logical cells
# LIMITATION only exact clear loops supported with no guest fuel or complete preflight
# LIMITATION clearing loops have no exact original command fuel accounting
# LIMITATION physical stream closure must be confirmed by an independent host
# LIMITATION emitted terminal status is a development envelope not COCK BFIO

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
  [[-]<<<
    # Consume the following two exact original guest commands
    >,>,

    # Require the closing bracket ASCII ninety three
    ---------------------------------------------------------------------------------------------
    >+<[[-]>[-]<]>

    # Accept the center opcode ASCII plus or minus and no other byte
    # Preserve the original center byte in a temporary cell four
    <<
    [->+>>+<<<]>[-<+>]<

    # Candidate plus ASCII forty three sets scratch cell two when equal
    -------------------------------------------
    >+<[[-]>[-]<]>

    # Candidate minus ASCII forty five is compared independently
    # Scratch cell seven temporarily holds the successful minus flag
    >>
    ---------------------------------------------
    >>>[-]+<<<
    [[-]>>>[-]<<<]>>>
    [-<<<<<+>>>>>]
    <<<<<

    # Execute a clearing loop only on an exact recognized two command suffix
    # Otherwise leave the unsupported instruction marker in place
    [[-]>[[-]<<<[-]>>>>>>>>>[-]<<<<<<<<<>>>]<]
    <<
    >>>
  ]
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
