# MODULE general forward bracket target probe
# PURPOSE find matching closing bracket for the first opening bracket
# INPUT a trusted normalized source suffix followed by a zero marker
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
# STATUS zero success two missing close ten overflow thirteen invalid opening

# Initialize the status to invalid opening and read the first source symbol
>>>>>>>+++++++++++++<<<<<<<,

# Compare the first source command to opening bracket ASCII ninety one
[->+>+<<]>>[-<<+>>]<
-------------------------------------------------------------------------------------------
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
  [[-]>>>>[-]>[-]++>>[-]<<<<<<<]
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

    # Opening brackets increase the nesting level
    [->+>+<<]>>[-<<+>>]<
    -------------------------------------------------------------------------------------------
    >+<[[-]>[-]<]>
    [[-]>+
      [-<<+>+>]<[->+<]<
      >+<[[-]>[-]<]>
      [[-]>>>>[-]>[-]++++++++++<<<<<]
    ]
    <<

    # Closing brackets decrease nesting and stop at its first return to zero
    [->+>+<<]>>[-<<+>>]<
    ---------------------------------------------------------------------------------------------
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
