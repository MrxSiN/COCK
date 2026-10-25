# MODULE retained binary input and explicit EOF reads
# PURPOSE supply exact guest bytes and EOF zero with real consumption count
# INPUT two byte length N then N raw bytes then A5
# INPUT two byte requested read count M then final A5
# OUTPUT zero status then M bytes then two byte consumed input count
# OUTPUT eleven alone if either length defined guard is invalid
# TAPE anchor one and two read count three and four scratch
# TAPE anchor five continuation six and seven consumed count
# TAPE records at eight stride eight zero backlink one value two occupied
# TAPE record three visited four through seven loading scratch
# PROFILE binary values including zero and FF are retained without sentinels
# PROFILE EOF writes zero and does not advance consumed count
# LIMITATION N and M are unsigned sixteen bit invocation widths
# REQUIREMENT independent exact N plus six input bytes and physical close
# PROVENANCE counted buffer admission reuses BF source duplication storage

# Retain the entire input before any guest output
>,>,<
[->>>>>>>>>>>+<<<<<<+<<<<<]>>>>>[-<<<<<+>>>>>
]
<<<<[->>>>>>>>>>>+<<<<<<<+<<<<]>>>>[-<<<<+>>>>]
>>[-]+>>>>>>>
<<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
<[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
[
  [-]<<<<<<,>+<
  >>>-[->>+<<<+>]<[->+<]>>>+>+<[[-]>[-]<]>
  [[-]<<->>]
  <<<[->>>>>>>>+<<<<<<<<]>[->>>>>>>>+<<<<<<<<]
  >>>>>>>><<<<<[-]+>>>>>>>
  <<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
  <[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
]
<<<<<<<[<<<<<<<<]

# Validate the retained input guard
>>>,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
>+<[[-]<<<[-]+++++ +++++ +>>>>[-]<]

# Read requested guest count and validate the final guard
<<[-],>[-],>[-],
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
[[-]<<<[-]+++++ +++++ +>>>>[-]<]
<<<.

# Start a guest read loop only after complete admission
>>>>[
  [-]>>[-]>[-]<<[-]
  <<<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>[-]+<<]
  <[->+>+<<]>>[-<<+>>]<[[-]>>[-]+<<]>>
  [
    [-]

    # Find the first retained byte not already consumed
    >>>>>>[>>>>>>>>]<
    [[-]>+>+<<]
    <.>>><<<<

    # Carry the real byte consumption flag back to the fixed anchor
    [>>>>[-<<<<<<<<+>>>>>>>>]<<<< <<<<<<<<]
    >>>>[
      [-]>>+
      [-<<<+>>+>]<[->+<]<+<
      [[-]>[-]<]>
      [[-]>>>+<<<]
    ]

    # Decrement the requested read count with checked byte borrow
    <<<[->>+>+<<<]>>>[-<<<+>>>]<
    >>+<<[[-]>>[-]<<]>>
    <<<<->>>>
    [[-]<<<->>>]

    # Continue until both count bytes are zero
    <<<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>[-]+<<]
    <[->+>+<<]>>[-<<+>>]<[[-]>>[-]+<<]>>
  ]
  >.>.<<<
]

# END binary EOF primitive with separate exact consumption
