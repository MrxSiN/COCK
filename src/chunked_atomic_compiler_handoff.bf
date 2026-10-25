# MODULE chunked atomic compiler handoff
# PURPOSE validate full normalized source before emitting loader instruction chunks
# INPUT repeated nonzero byte counts and exactly that many source command bytes
# INPUT one zero byte count and mandatory hexadecimal A5 completion guard
# OUTPUT on success byte one then one byte chunks and final zero source count
# OUTPUT on failure only one zero status byte and no released source commands
# TAPE cell zero current source input byte and cell one current chunk count
# TAPE cell two nesting depth and cell three sticky source rejection
# TAPE cells four and five comparator scratch
# TAPE cell six zero backtrack sentinel and seven alphabet flag
# TAPE cells eight onward two cells per command with occupied flag and byte
# BUDGET each chunk at most 255 commands and physical tape bounded by host resources
# LIMITATION current nesting depth representation is one unsigned byte
# LIMITATION original source offsets and annotated source grammar handled upstream
# LIMITATION exact host process and stream closure unimplemented here
# LIMITATION output status must be separated before source is passed to guest kernel
# LIMITATION not a COCK FRAME or HOST IO protocol encoder
# CONTRACT hold all source bytes until full validation and guard acceptance

# Read the first source chunk byte count into cell one
# Zero length means the complete source body has ended
>,[

  # Process every byte of this chunk before reading the next chunk length
  [
    -<,

  # Reset per byte membership evidence
  >>>>>>>[-]<<<<<<<

  # Check original plus byte
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- --->+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check original minus byte
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ----->+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check pointer movement left
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ---------- ---------- >+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check pointer movement right
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ---------- ---------- -->+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check guest output command
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ------>+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check guest input command
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ---->+<
  [[-]>[-]<]>[[-]>>+<<]<<<<<

  # Check opening bracket and increase depth
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ->+<
  [[-]>[-]<]>[[-]>>+<<<<<+>>>]<<<<<

  # Check closing bracket and flag prefix underflow
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- --->+<
  [[-]>[-]<]>[[-]>>+<<<<<-
    [->>+>+<<<]>>>[-<<<+>>>]<<<
    >>+>+<[[ -]>[-]<]>[[-]<<+>>]<<<
    >>>]<<<<<

  # Reject every byte not recognized as a genuine command
  >>>>>>>
  <<+>>[[-]<<[-]>>]
  <<[[-]<<+>>]
  <<<<<

  # Allocate a pending node and store the source byte on the tape
  >>>>>>>>[>>]+<<[<<]<<<<<<
  [->>>>>>>>[>>]<+<[<<]<<<<<<]

    # Continue to next byte within the current source chunk
    >
  ]

  # Read the next chunk length when the current chunk has completed
  ,
]

# Compare required guard to decimal one hundred sixty five
<,
[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
>>>>---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
[[-]<+>]<<<<

# Reject any opening bracket left unmatched
>>[[-]>+<]<<

# Derive final success flag and release status first
>>> >+<[[ -]>[-]<]>
.
[
  [-]
  # The buffered occupied flag is the literal chunk length one
  # Emit a chunk length then its source command for every buffered node
  # Emit the zero terminator only after the final buffered node
  >>>>[.>.>].<<[<<]<<
]

# END atomic admitted source handoff
