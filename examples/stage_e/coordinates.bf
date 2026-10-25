# MODULE coordinate label event handler
# PURPOSE derive a full provisional action from actual touch and prior state
# INPUT one dispatcher checked complete BFIO v1 event envelope
# INPUT handler seven schema two touch type one or surface type two
# INPUT prior state empty or eight coordinate bytes touch data exactly eight bytes
# OUTPUT one full provisional action with READY ODD or EVEN and next state
# OUTPUT no bytes when app fields or final guard are invalid
# REQUIREMENT dispatcher validates envelope correlation and physical exact closure
# REQUIREMENT dispatcher owns guest completion surface bounds rendering and commit
# TAPE zero invalid one and two scratch three through ten correlation
# TAPE eleven event type twelve state size thirteen event size fourteen state present
# TAPE fifteen touch sixteen surface seventeen through twenty four coordinates
# TAPE twenty five parity twenty six flip scratch twenty seven ready
# TAPE twenty eight even twenty nine odd thirty payload count thirty one text count
# TAPE thirty two emitted byte thirty three zero thirty six emission gate
# PROFILE schema two uses exactly two little endian unsigned coordinates

# Consume the independently checked sixteen byte envelope prefix
>>++++++++++++++++[<,[-]>-]

# Retain the complete correlation identifier without interpreting its bytes
>,>,>,>,>,>,>,>,

# Match handler seven and retain the event type
<<<<<<<< <,-------[[-]<[-]+>]
,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
>>>>>>>> >>,
<<<<<<<< <<,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]

# Match schema two and retain both full width lengths
,--[[-]<[-]+>]
,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
>>>>>>>> >>>,
<<<<<<<< <<<,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
>>>>>>>> >>>>,
<<<<<<<< <<<<,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]
,[[-]<[-]+>],[[-]<[-]+>],[[-]<[-]+>]

# Classify exactly the two registered event kinds
>>>>>>>> >>-
>>>>+<<<<[
  >>>>[-]>+<<<<<-
  [[-]<<<<<<<<<<<[-]+>>>>>>>> >>>>>>>>[-]<<<<<]
]

# App state is either empty or exactly eight bytes
>[
  >>[-]+<<--------
  [[-]<<<<<<<<<<<<[-]+>>>>>>>>>>>>]
]

# Touch consumes eight event bytes and surface ready consumes none
>>>[-<<<<<<<<<<<<<<+>+>>>>>>>>>>>>>]
<<<<<<<<<<<<<[->>>>>>>>>>>>>+<<<<<<<<<<<<<]<[
  [-]>>>>>>>> >>>>--------<<<<<<<< <<<<
]
>>>>>>>> >>>>[[-]<<<<<<<<<<<<<[-]+>>>>>>>>>>>>>]

# Read prior coordinate state only when present
>[-<<<<<<<<<<<<<+>+>>>>>>>>>>>>]
<<<<<<<<<<<<[->>>>>>>>>>>>+<<<<<<<<<<<<]<[
  [-]>>>>>>>> >>>>>>>>,>,>,>,>,>,>,>,
  <<<<<<<< <<<<<<<< <<<<<<<
]

# A touch replaces state with the actual incoming coordinate bytes
>>>>>>>> >>>>>>[
  [-]>>,>,>,>,>,>,>,>,
  <<<<<<<<<<[-]+>
]

# The frame must be complete before any action is emitted
<<<<<<<< <<<<<<,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
[[-]<[-]+>]

# Derive parity from the low byte of the actual x coordinate
>>>>>>>> >>>>>>>>[-<<<<<<<<<<<<<<<<+>+>>>>>>>>>>>>>>>]
<<<<<<<<<<<<<<<[->>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<]<[
  ->>>>>>>> >>>>>>>> >>>>>>>>
  [->+<]+>[-<->]
  <<<<<<<< <<<<<<<< <<<<<<<< <
]

# Initial empty state renders READY
>>>>>>>> >>>>>>>> >>>>>>>> >>+
>>>+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
>+++++

# Existing or incoming coordinate state renders its parity
<<<<<<<< <<<<<<<<<[-<<<<<<<<<<<<<+>+>>>>>>>>>>>>]
<<<<<<<<<<<<[->>>>>>>>>>>>+<<<<<<<<<<<<]<[
  [-]>>>>>>>> >>>>>>>> >>>>>>>> >>[-]>[-]+
  >>[-]+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ ++
  >[-]++++
  <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<
]
>>>>>>>> >>>>>>>> >>>>>>>>
[
  [-]>>>[-]>[-]+>[-]+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +
  >[-]+++<<<<<<
]

# Invalid app input cannot emit a provisional action
>>>>>>>> >>>+
<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<[
  [-]>>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>[-]<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<
]
>>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>[
  [-]<<<<

  # Emit BFIO v1 action header with the computed exact payload length
  ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++.
  ++++.+++.++++++.[-]+.[-].++++.[-].
  <<.>>>.......
  <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<
  .>.>.>.>.>.>.>.

  # Handler seven action one flags zero schema two
  >>>>>>>> >>>>>>>> >>>>>>+++++++.[-]>...
  <+.[-]>...
  <++.[-]>.......

  # Emit zero or eight state bytes as declared
  <<<<<<<< <<<<<<<< <<<[-<<<<<<<<<<<<<+>+>>>>>>>>>>>>]
  <<<<<<<<<<<<[->>>>>>>>>>>>+<<<<<<<<<<<<]<[
    [-]>>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>++++++++<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<
  ]
  >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>.[-]>.......

  # Action body length is eight plus the actual text count
  <<[->+>+<<]>>[-<<+>>]<++++++++.[-]>.......

  # State bytes retain exact unsigned binary coordinates
  <<<<<<<< <<<<<<<< <<<[-<<<<<<<<<<<<<+>+>>>>>>>>>>>>]
  <<<<<<<<<<<<[->>>>>>>>>>>>+<<<<<<<<<<<<]<[
    [-]>>>>>>>> >>>>>>>>.>.>.>.>.>.>.>.
    <<<<<<<< <<<<<<<< <<<<<<<
  ]

  # UI text body version reserved word and exact text count
  >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>+.[-]>...
  <<.>>...

  # READY
  <<<<<<[
    [-]>>>>>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++.
    ------------- .----.+++.++++++++++ ++++++++++ +.[-]<<<<<
  ]

  # EVEN
  >[
    [-]>>>>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ +++++++++.
    ++++++++++ +++++++.---------- -------.+++++++++.[-]<<<<
  ]

  # ODD
  >[
    [-]>>>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ +++++++++.
    ---------- -..[-]<<<
  ]
  >>>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++
  ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ +++++.[-]
  >>>>
]

# END one app action with no forged dispatcher status
