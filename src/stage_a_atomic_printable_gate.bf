# MODULE Stage A atomic printable arithmetic guest admission
# PURPOSE admit a complete normalized arithmetic guest before releasing bytes
# INPUT one unsigned length byte then exact commands then A5 guard
# OUTPUT success byte one and full command stream or failure byte zero alone
# TAPE zero bytes remaining and one current byte
# TAPE two guest value and three terminal output seen
# TAPE four sticky rejection and five six comparison scratch
# TAPE seven recognized glyph and eight nonmatch scratch
# TAPE ten through seventeen checked printable result arithmetic scratch
# TAPE nineteen pending source byte and twenty onward reverse order buffer
# BUDGET current record length at most 255 bytes
# BUDGET physical tape memory and outer execution separately bounded
# LIMITATION input must already be normalized by an accepted source preflight
# LIMITATION trusted final host closure and original offsets absent
# LIMITATION diagnostic record is not a published framed protocol
# CONTRACT no accepted source bytes are emitted before complete admission

# Read byte count into remaining length cell
,[
  # Consume exactly one declared byte
  -
  >,

  # A command after the terminal output instruction rejects the record
  >>[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<[[-]<<<[-]+>>>]<<<<<<

  # Clear character recognition state
  >>>>>>[-]<<<<<<

  # Identify arithmetic addition by its ASCII value
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- --->+<
  [[-]>[-]<]
  >[[-]>+<<<<<+>>>>]<<<<<

  # Identify arithmetic subtraction by its ASCII value
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ----->+<
  [[-]>[-]<]
  >[[-]>+<<<<<->>>>]<<<<<

  # Identify the single terminal guest output instruction
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>---------- ---------- ---------- ---------- ------>+<
  [[-]>[-]<]
  >[[-]>+<<<<+>>>]<<<<<

  # Any other instruction or byte fails without producing source
  >>>>>> >+<
  [[-]>[-]<]
  >[[-]<<<<[-]+>>>>]<<<<<<<

  # Replace a rejected zero input with a nonzero internal sentinel
  # This keeps the reverse order tape representation well formed
  >>>>>>>[-]+<<<<<<<
  [->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
  >>>>[[ -]>>>[-]<<<]>>>[[-]<<<<[-]+<<<+>>>>>>>]<<<<<<<

  # Move current byte to pending slot while preserving its literal value
  [->>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<]

  # Push byte onto nonzero reverse order buffer and restore pointer zero
  >>>>>>>>>> >>>>>>>>>[>]
  <[[->+<]<]
  <<<<<<<<<< <<<<<<<<
]

# Read and check the mandatory nonzero completion guard
>,
[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<<<<<
>>>>---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
[[-]<[-]+>]
<<<<<

# Require one terminal output command
>>> >>>>>[-]+<<<<<
[->>>>>[-]<<<<<]
>>>>>[[-]<<<<[-]+>>>>]
<<<<<<<<

# Transfer emulated guest result to the printable range checker
>>[->>>>>>>>+<<<<<<<<]<<

# Check result has at least thirty two unsigned units
>>>>>>>>>>>[-]++++++++++ ++++++++++ ++++++++++ ++
[
  -<
  [->>+>+<<<]>>[-<<+>>]
  >>[-]+<
  [[-]<<<->>>>[-]<]
  >[[-]<<<[-]>>><<<<<<<<<<[-]+>>>>>>>>>>]
  <<<
]

# Check remaining amount stays below ninety five units
[-]++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ +++++
[
  -<
  [->>+>+<<<]>>[-<<+>>]
  >>[-]+<
  [[-]<<<->>>>[-]<]
  >[[-]<<<[-]>>>>>[-]+<<]
  <<<
]

# Exhaustion before ninety five means the upper bound is respected
>>>>> >[-]+<
[[-]>[-]<]
>[[-]<<<<<<<<<<<<<[-]+>>>>>>>>>>>>>]
<<<<<<<<<<<<<<<<<

# Derive final status from sticky rejection flag
>>>> >[-]+<
[[-]>[-]<]
>.

# Only on success emit buffered instructions from oldest to newest
[
  [-]
  >>>>>>>>>> >>>>>[>]
  <[.[-]<]
]

# END bounded atomic arithmetic admission
