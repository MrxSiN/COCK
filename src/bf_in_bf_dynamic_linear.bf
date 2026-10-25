# MODULE COCK dynamic linear guest tape interpreter
# PURPOSE evaluate trusted straight line guest instructions with growing tape
# INPUT already admitted raw guest instructions followed by a zero terminator
# INPUT host byte count and successful stream closure are external prerequisites
# OUTPUT guest bytes followed by one terminal status byte
# TAPE every twelve outer cells represent one logical guest cell
# TAPE first cell is guest value and second is current input opcode
# TAPE third cell is comparison scratch and fourth is matching flag
# TAPE fifth cell records right travel and sixth stores execution control
# TAPE seventh marks logical guest address zero and eighth records left travel
# TAPE tenth is invalid command marker and twelfth is terminal result
# PROFILE arithmetic wraps at eight bits and new guest cells start at zero
# PROFILE guest source admits only addition subtraction left right and output
# LIMITATION guest loops input command fuel and complete source preflight absent
# LIMITATION physical stream closure must be confirmed by an independent host
# LIMITATION emitted terminal status is a development envelope not COCK BFIO

# Initialize origin sentinel and active interpreter loop
>>>>>+>+<

# Interpret one supplied original guest instruction each iteration
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

# Right movement transfers the active token into the following tape record
[[-]>[-]>>>>>>>>>>>>+<]

# Return to the current guest record active token
>
]

# A single terminal status byte follows all diagnostic guest output
>>>>>>.

# END dynamic linear guest tape diagnostic
