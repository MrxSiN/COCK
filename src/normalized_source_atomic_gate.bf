# MODULE atomic normalized source admission
# PURPOSE withhold normalized source bytes until all checks pass
# INPUT one unsigned count byte followed by that many raw source bytes
# INPUT mandatory hexadecimal A5 completion guard after declared bytes
# OUTPUT status byte one and original bytes only when accepted
# OUTPUT status byte zero and no source bytes on rejection
# TAPE cell zero current input and one remaining source length
# TAPE cell two nesting depth and three sticky rejection
# TAPE cells four and five comparator scratch
# TAPE cell six zero backtrack sentinel and seven alphabet flag
# TAPE cells eight onward pairs of occupied flag and source byte
# BUDGET count at most 255 and loop nesting at most 255
# LIMITATION only original eight command input is accepted
# LIMITATION guard cannot independently attest physical stream closure
# LIMITATION malformed bytes are buffered but never emitted on rejection
# LIMITATION no original source offset status or guest fuel yet

# Read bounded count and enter complete record scan
>,[
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

  # Continue to next declared source byte
  >
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
  # Emit every buffered command only after completed validation
  >>>>[>.>]<<[<<]<<
]

# END atomic admitted source handoff
