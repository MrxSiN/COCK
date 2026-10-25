# MODULE single entry stored ZIP serialization
# PURPOSE generate real local central and end records from variable path and bytes
# INPUT unsigned two byte nonzero path length then exact path then A5
# INPUT unsigned two byte data length then four CRC bytes then exact data then A5
# OUTPUT actual ZIP bytes with central directory only after complete final guard
# PROFILE stored method UTF8 flag fixed DOS date first day of year nineteen eighty
# TAPE one and two path size three and four data size five through eight CRC
# TAPE thirteen through sixteen central size seventeen through twenty local area size
# TAPE twenty one and twenty two copies twenty three zero test twenty four zero anchor
# TAPE twenty five and twenty six remaining count twenty seven continuation
# TAPE twenty eight zero twenty nine emitted byte thirty admission
# TAPE path records start at thirty two with stride eight
# TAPE record zero backlink one byte two occupied three visited four and five loading count
# REQUIREMENT BF caller validates nonempty canonical UTF8 path and actual CRC
# REQUIREMENT physical exact counts close and independent ZIP validation before publication
# LIMITATION one stored entry no compression APK alignment signing or ZIP64
# LIMITATION malformed final input can leave a provisional incomplete local prefix

# Retain exactly one path buffer for both archive name occurrences
>,>,<
[->>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>+<<<<<<<< <<<<<<<< <<<<<<<< <+<<<<<<<< <<]
>>>>>>>> >>[-<<<<<<<< <<+>>>>>>>> >>]
<<<<<<<< <
[->>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>+<<<<<<<< <<<<<<<< <<<<<<<< <+<<<<<<<< <<]
>>>>>>>> >>[-<<<<<<<< <<+>>>>>>>> >>]
>>>>>>>> >>>>>>>> >>>>+>>>>>>>
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
<<<<<<<< <<<<<<<< <<<<<<<<

# Reject a truncated path before writing any local header
>>>>>>>> >>>,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
>>>>>>>> >>>>>>>> >>>+
<<<<<<<< <<<<<<<< <<<[[-]>>>>>>>> >>>>>>>> >>>[-]<<<<<<<< <<<<<<<< <<<]
>>>>>>>> >>>>>>>> >>>[
  [-]<<<<<<<< <<<<<<<< <<<<<<<< <<<,>,>,>,>,>,

  # Base sizes of the central and local fixed headers
  >>>>>+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +
  >>>>+++++ +++++ +++++ +++++ +++++ +++++

  # Copy the retained path size to a separate output counter
  <<<<<<<< <<<<<<<<
  [->>>>>>>> >>>>>>>> >>>>>>>>+<<<<+<<<<<<<< <<<<<<<< <<<<]
  >>>>>>>> >>>>>>>> >>>>[-<<<<<<<< <<<<<<<< <<<<+>>>>>>>> >>>>>>>> >>>>]
  <<<<<<<< <<<<<<<< <<<
  [->>>>>>>> >>>>>>>> >>>>>>>>+<<<<+<<<<<<<< <<<<<<<< <<<<]
  >>>>>>>> >>>>>>>> >>>>[-<<<<<<<< <<<<<<<< <<<<+>>>>>>>> >>>>>>>> >>>>]

  # Local file header with exact CRC lengths and no data descriptor
  >>>>>>>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++.
  -----.[-]+++.+.[-]
  +++++ +++++ +++++ +++++.[-]<..
  >++++++++.[-]<....
  >++++++++++ ++++++++++ ++++++++++ +++.[-]<.
  <<<<<<<< <<<<<<<< <<<<<<<.>.>.>.
  <<<<<.>.>>>>>>>> >>>>>>>> >>>>>>>>..
  <<<<<<<< <<<<<<<< <<<<<<<< <.>.>>>>>>>> >>>>>>>> >>>>>>>>..
  <<<<<<<< <<<<<<<< <<<<<<<< <<<.>.>>>>>>>> >>>>>>>> >>>>>>>> >>..

  # Continue while either path count byte remains
  <<<[-<<<<+>+>>>]<<<[->>>+<<<]<[[-]>>>>>>[-]+<<<<<<]
  >>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]<[[-]>>>>>>[-]+<<<<<<]>>>>>>
  [
    [-]>>>>>>>>[>>>>>>>>]+<<.<[<<<<<<<<]
    <<<<<<<< <<<<<<<< <<<<<<<<

    # Count each serialized name byte in central header size
    >>>>>>>> >>>>>+
    [->>>>>>>>+>+<<<<<<<<<]>>>>>>>>>[-<<<<<<<<<+>>>>>>>>>]<
    >>+<<[[-]>>[-]<<]>>[
      [-]<<<<<<<< <+
      [->>>>>>>+>+<<<<<<<<]>>>>>>>>[-<<<<<<<<+>>>>>>>>]<
      >>+<<[[-]>>[-]<<]>>[[-]<<<<<<<<+>>>>>>>>]
    ]

    # Count each serialized name byte in the local area offset
    <<<<<<+
    [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<
    >>+<<[[-]>>[-]<<]>>[
      [-]<<<<<+
      [->>>+>+<<<<]>>>>[-<<<<+>>>>]<
      >>+<<[[-]>>[-]<<]>>[[-]<<<<+>>>>]
    ]

    # Decrement path count and preserve exact original header sizes
    >>[-<<<<+>+>>>]<<<[->>>+<<<]<
    >>+<<[[-]>>[-]<<]>>
    >>-<<[[-]>>>-<<<]
    >>[-<<<<+>+>>>]<<<[->>>+<<<]<[[-]>>>>>>[-]+<<<<<<]
    >>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]<[[-]>>>>>>[-]+<<<<<<]>>>>>>
  ]

  # Copy the data size to the same remaining count
  <<<<<<<< <<<<<<<< <<<<<<<<
  [->>>>>>>> >>>>>>>> >>>>>>+<<<<+<<<<<<<< <<<<<<<< <<]
  >>>>>>>> >>>>>>>> >>[-<<<<<<<< <<<<<<<< <<+>>>>>>>> >>>>>>>> >>]
  <<<<<<<< <<<<<<<< <
  [->>>>>>>> >>>>>>>> >>>>>>+<<<<+<<<<<<<< <<<<<<<< <<]
  >>>>>>>> >>>>>>>> >>[-<<<<<<<< <<<<<<<< <<+>>>>>>>> >>>>>>>> >>]
  >>>[-<<<<+>+>>>]<<<[->>>+<<<]<[[-]>>>>>>[-]+<<<<<<]
  >>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]<[[-]>>>>>>[-]+<<<<<<]>>>>>>
  [
    [-]>>,. [-]

    # Physical output byte increases the computed central directory offset
    <<<<<<<< <<<<+
    [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<
    >>+<<[[-]>>[-]<<]>>[
      [-]<<<<<+
      [->>>+>+<<<<]>>>>[-<<<<+>>>>]<
      >>+<<[[-]>>[-]<<]>>[[-]<<<<+>>>>]
    ]
    >>[-<<<<+>+>>>]<<<[->>>+<<<]<
    >>+<<[[-]>>[-]<<]>>
    >>-<<[[-]>>>-<<<]
    >>[-<<<<+>+>>>]<<<[->>>+<<<]<[[-]>>>>>>[-]+<<<<<<]
    >>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]<[[-]>>>>>>[-]+<<<<<<]>>>>>>
  ]

  # No central directory is produced if the final data guard is absent
  >>,
  ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
  ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
  >+<[[-]>[-]<]>[
    [-]<

    # Central file header is derived from the same metadata and retained name
    ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++.
    -----.[-]+.+.[-]
    +++++ +++++ +++++ +++++.[-]<.
    >+++++ +++++ +++++ +++++.[-]<..
    >++++++++.[-]<....
    >++++++++++ ++++++++++ ++++++++++ +++.[-]<.
    <<<<<<<< <<<<<<<< <<<<<<<.>.>.>.
    <<<<<.>.>>>>>>>> >>>>>>>> >>>>>>>>..
    <<<<<<<< <<<<<<<< <<<<<<<< <.>.>>>>>>>> >>>>>>>> >>>>>>>>..
    <<<<<<<< <<<<<<<< <<<<<<<< <<<.>.>>>>>>>> >>>>>>>> >>>>>>>> >>................

    # Replay the identical path without a second input source read
    >>>>>>[<.> >>>>>>>>]<<[<<<<<<<<]
    <<<<<<<< <<<<<<<< <<<<<<<<

    # End of central directory with checked computed four byte fields
    >>>>>>>> >>>>>>>> >>>>>>>> >>>>>
    ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++.
    -----.[-]+++++.+.[-]<....
    >+.[-]<.>+.[-]<.
    <<<<<<<< <<<<<<<.>.>.>.>.>.>.>.
    >>>>>>>>..>>
  ]
]

# END candidate ZIP bytes requiring independent CRC and finalization authority
