# MODULE strict UI basic text body validator
# PURPOSE validate exact version reserved length and printable text in BF
# INPUT version two bytes reserved two bytes length four bytes text then A5
# OUTPUT zero valid eleven malformed twelve unsupported version fourteen bad text
# PROFILE body is COCK UI BASIC v1 text action data with extra private guard
# TAPE one through four unsigned little endian remaining text length
# TAPE five byte six and seven copies eight zero flag nine continuation
# TAPE eleven malformed twelve version thirteen bad text
# TAPE fourteen comparison count fifteen below threshold sixteen scratch
# REQUIREMENT caller binds exact body size input count and physical closure
# LIMITATION rendering capability and window lifetime are checked elsewhere

# Validate the two version bytes and reserved bytes
>>>>>,-[[-]>>>>>>>[-]+<<<<<<<]
,[[-]>>>>>>>[-]+<<<<<<<]
,[[-]>>>>>>[-]+<<<<<<]
,[[-]>>>>>>[-]+<<<<<<]

# Retain the complete unsigned thirty two bit text count
<<<<,>,>,>,<<<
[->>>>>+>+<<<<<<]>>>>>>[-<<<<<<+>>>>>>]<[[-]>>>[-]+<<<]
<<<<[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<[[-]>>>[-]+<<<]
<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,

  # Wrapped subtraction maps exactly printable ASCII into zero through ninety four
  -------- -------- -------- --------
  >>>>>>>>>[-]
  ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++
  ++++++++++ ++++++++++ ++++++++++ ++++++++++ +++++
  [
    -<<<<<<<<<
    [->+>+<<]>>[-<<+>>]<
    >>+<<[[-]>>[-]<<]>>
    [[-]>>>>>>[-]>[-]+<<<<<<<]
    <<<->>>>>>>>>
  ]
  >>+<[[-]>[-]<]>[[-]<<<[-]+>>>]
  <<<<<<<<<<<[-]

  # Decrement the full width length with original byte carry ordering
  <<<<[->>>>>+>+<<<<<<]>>>>>>[-<<<<<<+>>>>>>]<
  >>+<<[[-]>>[-]<<]>>
  <<<<<<<->>>>>>>
  [
    [-]<<<<<<[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<
    >>+<<[[-]>>[-]<<]>>
    <<<<<<->>>>>>
    [
      [-]<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<
      >>+<<[[-]>>[-]<<]>>
      <<<<<->>>>>
      [[-]<<<<->>>>]
    ]
  ]

  # Continue until every declared text byte has been checked
  <<<<<<<[->>>>>+>+<<<<<<]>>>>>>[-<<<<<<+>>>>>>]<[[-]>>>[-]+<<<]
  <<<<[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<[[-]>>>[-]+<<<]
  <<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]

# A lost or misplaced final byte cannot be mistaken for a complete body
<<<<,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
[[-]>>>>>>[-]+<<<<<<]

# Structural failure outranks version failure and bad alphabet
>>>>>>>>[
  [-]<<<<<<<<<<<<<[-]+++++ +++++ ++++>>>>>>>>>>>>>
]
<[
  [-]<<<<<<<<<<<<[-]+++++ +++++ ++>>>>>>>>>>>>
]
<[
  [-]<<<<<<<<<<<[-]+++++ +++++ +>>>>>>>>>>>
]
<<<<<<<<<<<.

# END atomic text body admission without a renderer claim
