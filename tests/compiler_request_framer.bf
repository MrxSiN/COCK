# MODULE COCK diagnostic compiler request framer
# PURPOSE send admitted compiler commands to the six cell BF interpreter loader
# INPUT normalized compiler commands then ASCII bang delimiter then admitted app bytes
# OUTPUT one command per source chunk then zero terminator then app bytes
# TAPE cell zero holds the current compiler source command
# TAPE cell one checks for the ASCII bang delimiter
# TAPE cell two is the continue flag and also emits a zero chunk terminator
# TAPE cell three is an arithmetic copy scratch cell
# PRECONDITION exact source counts and host stream closure verified outside this module
# LIMITATION missing delimiter or NUL cannot be detected reliably from BF EOF semantics
# LIMITATION raw guest byte zero is not supported by the app input relay
# STATUS diagnostic framing only not a production BFIO or BHIO serializer

# Keep reading source instructions until the declared delimiter
>>+
[
  <<,

  # Copy the current byte to the delimiter test while preserving source data
  [->+>>+<<<]
  >>>[-<<<+>>>]<<<

  # Clear the loop continuation marker before checking the current byte
  >>[-]<<
  >---------------------------------

  # A non delimiter source byte forms a source chunk of length one
  [
    [-]>+<
    +.-
    <.>
  ]
  >
]

# Emit a zero source chunk to end source loading
.

# Relay the admitted arithmetic application input unchanged until EOF zero
<<,[.,]

# END request framer
