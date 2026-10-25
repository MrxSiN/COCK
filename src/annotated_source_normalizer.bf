# MODULE annotated source command projection
# PURPOSE extract the eight original BF commands from admitted source
# INPUT exact complete and already validated annotated source bytes
# OUTPUT original eight command bytes in their order of appearance
# TAPE cell zero is the current input byte
# TAPE cell one is equality scratch
# TAPE cell two is copy scratch and equality flag
# REQUIREMENT source preflight and host closure precede use
# LIMITATION this module does not validate comments input or closure
# LIMITATION malformed zero input is indistinguishable from physical EOF
# STATUS diagnostic transformation not production authority

,[
  # Try ASCII decimal forty three
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal forty four
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ----
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal forty five
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- -----
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal forty six
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ------
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal sixty
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ----------
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal sixty two
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- --
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal ninety one
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Try ASCII decimal ninety three
  [->+>+<<]>>[-<<+>>]<<
  >---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---
  >+<
  [[-]>[-]<]
  >[<<.>>[-]]
  <<

  # Fetch the next byte of admitted source
  ,
]

# END source projection complete
