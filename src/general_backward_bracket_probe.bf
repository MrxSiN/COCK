# MODULE general backward bracket target probe
# PURPOSE find matching opening bracket for the first closing bracket
# INPUT a trusted reversed normalized prefix beginning with a close bracket then zero marker
# INPUT the independent host must establish exact input and stream closure
# OUTPUT two little endian distance bytes then one diagnostic status byte
# TAPE zero holds current input symbol
# TAPE one and two are preserved comparison and copying scratch
# TAPE three counts bracket nesting and four five count source distance
# TAPE six is running state and seven is the diagnostic status
# TAPE nine is the current input presence flag
# LIMITATION this probe is not full source preflight or a guest interpreter
# LIMITATION the private byte distance format handles checked sixteen bit distances
# LIMITATION nested bracket depth may not exceed two hundred fifty five
# STATUS zero success three missing open ten overflow thirteen invalid closing

# Initialize the status to invalid closing and read the first source symbol
>>>>>>>+++++++++++++<<<<<<<,

# Compare the first source command to closing bracket ASCII ninety three
[->+>+<<]>>[-<<+>>]<
---------------------------------------------------------------------------------------------
>+<[[-]>[-]<]>
[[-]>+>>>+>[-]<<<<<]
<<

# Read and inspect commands while a matching closing bracket is still needed
>>>>>>[
  <<<<<<,

  # A source byte equal to zero terminates this diagnostic suffix
  >>>>>>>>>+<<<<<<<<<
  [->+>+<<]>>[-<<+>>]<
  >+<[[-]>[-]<]>
  [[-]>>>>[-]>[-]+++>>[-]<<<<<<<]
  <<

  # Only a present byte may alter the distance or nesting level
  >>>>>>>>>[
    [-]<<<<<<<<<

    # Increment a checked sixteen bit relative source distance
    >>>>+
    [-<<<+>+>>]<<[->>+<<]<
    >+<[[-]>[-]<]>
    [[-]>>>+
      [-<<<<+>+>>>]<<<[->>>+<<<]<
      >+<[[-]>[-]<]>
      [[-]>>>>[-]>[-]++++++++++<<<<<]
    ]
    <<

    # Closing brackets increase the nesting level
    [->+>+<<]>>[-<<+>>]<
    ---------------------------------------------------------------------------------------------
    >+<[[-]>[-]<]>
    [[-]>+
      [-<<+>+>]<[->+<]<
      >+<[[-]>[-]<]>
      [[-]>>>>[-]>[-]++++++++++<<<<<]
    ]
    <<

    # Opening brackets decrease nesting and stop at its first return to zero
    [->+>+<<]>>[-<<+>>]<
    -------------------------------------------------------------------------------------------
    >+<[[-]>[-]<]>
    [[-]>-
      [-<<+>+>]<[->+<]<
      >+<[[-]>[-]<]>
      [[-]>>>>[-]<<<<]
    ]
    <<

    # Return to the input presence flag for the current pass
    >>>>>>>>>
  ]
  <<<
]

# Zero both target bytes if the result is a failure
>[->+>+<<]>>[-<<+>>]<
[[-]<<<<[-]>[-]>>>]
<<

# All diagnostic bytes are emitted after the scanner stops
<<.>.>>.
# END general bracket target probe
