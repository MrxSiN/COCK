# MODULE guarded source buffer duplication
# PURPOSE derive identical two pass input from one retained byte buffer
# INPUT unsigned two byte count then exact bytes then A5 guard
# OUTPUT retained bytes then zero separator then same retained bytes
# OUTPUT no bytes when the length defined guard is invalid
# TAPE zero anchor one and two original count three guard four admission
# TAPE records start at eight with stride eight
# TAPE record zero backlink one byte two occupied marker three scratch
# TAPE record four and five remaining count six scratch seven continuation
# PROFILE wrapping byte cells raw binary output and zero at EOF
# REQUIREMENT caller validates normalized source before using it as compiler input
# LIMITATION physical count read close and final transport closure remain external
# PROVENANCE counted buffer storage reuses the independent BF byte comparator

# Read count and retain a mobile copy for record admission
>,>,<
[->>>>>>>>>>>+<<<<<<+<<<<<]>>>>>[-<<<<<+>>>>>
]
<<<<[->>>>>>>>>>>+<<<<<<<+<<<<]>>>>[-<<<<+>>>>]
>>[-]+>>>>>>>

# Determine whether a counted byte remains
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

# Accept only a complete nonzero guard at its declared position
>>>,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
>+<[[ -]>[-]<]>
[
  [-]<<<<

  # Emit the first retained byte sequence using occupied record markers
  >>>>>>>> >>[<.> >>>>>>>>]
  <<[<<<<<<<<]

  # Emit the source terminator from the untouched zero anchor
  .

  # Emit the same byte sequence without a second source read
  >>>>>>>> >>[<.> >>>>>>>>]
  <<[<<<<<<<<]>>>>
]

# END provisional binary two pass transport
