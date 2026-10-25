# MODULE mini compiler
# PURPOSE encode a normalized arithmetic guest as raw AArch64 words
# INPUT verified exact source using only plus minus and one final output command
# OUTPUT little endian native code words implementing unsigned byte arithmetic
# TAPE cell zero source byte
# TAPE cell one plus branch flag
# TAPE cell two command residue
# TAPE cell three minus branch flag
# TAPE cell four output byte scratch
# TAPE cell five output constant multiplier
# PRECONDITION complete BF authored preflight and trusted input closure
# STATUS partial Stage A component without native Android entry or input authority

# Begin with machine instruction initializing return register to zero
>>>>
..
++++++++[>++++++++++++++++<-]>.[-]<
++++++++[>++++++++++<-]>++.[-]<
<<<<

# Read one source command then process until physical end of input
,[
  # Normalize ASCII plus into zero and minus into two
  -------------------------------------------

  # Derive one plus flag and preserve a nonzero residue for the minus test
  >+<
  [->>+<[-]<]

  # Emit native increment and unsigned byte reduction for a plus command
  >[
    >>>
    .++++.[-].+++++++++++++++++.[-]
    .++++++++++++++++++++++++++++.[-].
    ++++++++[>++++++++++<-]>+++.[-]<
    <<<-
  ]

  # Detect ASCII minus using the normalized source residue
  >--
  >+<
  [[-]>[-]<]

  # Emit native decrement and unsigned byte reduction for a minus command
  >[
    >
    .++++.[-].
    ++++++++[>++++++++++<-]>+.[-]<
    .++++++++++++++++++++++++++++.[-].
    ++++++++[>++++++++++<-]>+++.[-]<
    <-
  ]

  # Fetch the next source byte and continue
  <<<,
]

# Emit the final native return instruction
>>>>
++++++++++++[>++++++++++++++++<-]>.[-]<
+++.[-]
+++++++++[>++++++++++<-]>+++++.[-]<
++++++++++++++++++++[>++++++++++<-]>++++++++++++++.[-]<

# END mini compiler raw native code complete
