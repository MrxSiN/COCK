# MODULE COCK normalized source byte offset gate
# PURPOSE validate a bounded exact length normalized guest command record
# INPUT one unsigned length byte then exactly that many source bytes
# INPUT one mandatory hexadecimal A5 completion guard byte
# OUTPUT one diagnostic status byte followed by one source byte offset
# TAPE zero holds remaining source length
# TAPE one holds diagnostic status
# TAPE two holds the original zero based source offset
# TAPE three holds the first rejected offset or FF when not applicable
# TAPE four holds the current source byte
# TAPE five and six are comparison scratch
# TAPE seven is the equality flag and eight is admitted flag
# TAPE nine is the rejection flag and ten is first error latch
# STATUS zero accepted one invalid source byte eleven malformed record
# LIMITATION accepts normalized eight command alphabet only
# LIMITATION no bracket matching or annotated source parsing
# LIMITATION one byte length and offset with explicit transport closure required
# SAFETY emits no guest source or guest output before the final guard

# Initialize missing offset sentinel and first error latch
>>>->>>>>>>+<<<<<<<<<<,

# Consume the entire declared record before publishing a result
[
  >>>>,>>>>[-]<<<<

  # Check ASCII addition command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII input command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ----
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII subtraction command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- -----
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII output command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ------
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII left movement command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ----------
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII right movement command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- --
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII opening bracket command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Check ASCII closing bracket command
  >[-]>[-]<<[->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---
  >>+<<[[-]>>[-]<<]>>[[-]>+<]<<<

  # Retain only the first invalid original command offset
  >>>>>+<[[-]>[-]<]>[
    [-]>[
      [-]<<<<<<<<
      >[-]>>[-]<<<[->+>>+<<<]>>>[-<<<+>>>]
      <<<<+>>>>>>>>>
    ]<
  ]

  # Advance original source offset and decrease unread byte count
  <<<<<<<+<<-
]

# Require a nonzero guard so EOF zeros cannot complete a truncated record
>>>>,
++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++
++++++++++ ++++++++++ ++++++++++ ++++++++++ +
[[-]<<<[-]+++++++++++>>[-]->]

# Emit only the terminal diagnostic status and the first invalid offset
<<<.>>.

# END normalized source byte offset gate
