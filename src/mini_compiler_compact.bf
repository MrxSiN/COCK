# MODULE compact arithmetic AArch64 compiler
# PURPOSE emit source dependent native arithmetic words with one final byte reduction
# INPUT trusted normalized plus and minus commands followed by one output command
# OUTPUT raw little endian AArch64 words and no ELF container
# TAPE cell zero input command
# TAPE cell one plus classification flag
# TAPE cell two minus command residue
# TAPE cell three minus classification flag
# TAPE cell four output constant scratch
# TAPE cell five constant multiplier scratch
# PRECONDITION independently validated complete guest source and host closure
# LIMITATION loop free no input single cell and no guest fuel
# CONTRACT each arithmetic command emits one native instruction
# CONTRACT one final modulo byte operation preserves the admitted guest result

# Emit zero initialization of native return register
>>>>
..
++++++++[>++++++++++++++++<-]>.[-]<
++++++++[>++++++++++<-]>++.[-]<
<<<<

# Read each validated arithmetic command until physical input ends
,[
  # Normalize ASCII addition to zero
  -------------------------------------------

  # Classify addition without losing the subtraction residue
  >+<
  [->>+<[-]<]

  # Emit one AArch64 register addition by one
  >[
    >>>
    .++++.[-].+++++++++++++++++.[-]
    <<<-
  ]

  # Classify subtraction using the remaining source residue
  >--
  >+<
  [[-]>[-]<]

  # Emit one AArch64 register subtraction by one
  >[
    >
    .++++.[-].
    +++++[>++++++++++++++++<-]>+.[-]
    <<-
  ]

  # Read next validated command
  <<<,
]

# Emit one final extraction of the low unsigned byte
>>>>
.++++++++++++++++++++++++++++.[-].
++++++++[>++++++++++<-]>+++.[-]<

# Return through the native platform calling convention
++++++++++++[>++++++++++++++++<-]>.[-]<
+++.[-]
+++++++++[>++++++++++<-]>+++++.[-]<
++++++++++++++++++++[>++++++++++<-]>++++++++++++++.[-]<

# END compact raw native generator
