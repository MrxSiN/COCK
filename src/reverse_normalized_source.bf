# MODULE reverse normalized command stream
# PURPOSE reverse an admitted command stream without host semantic processing
# INPUT admitted nonzero BF command bytes followed by one zero terminator
# INPUT independent host exact byte count and successful closure are required
# OUTPUT the command bytes in reverse order with no status or delimiters
# TAPE record stride is three cells
# TAPE first cell stores source command and second stores occupied flag
# TAPE an empty sentinel record occupies the first three cells
# LIMITATION source zero cannot be represented by this diagnostic interface
# LIMITATION caller must perform full source preflight and closure validation

# Move past the reserved sentinel and push each nonzero command
>>>
,[
  >+<
  >>>,
]

# Starting with the last occupied record emit each saved byte
# The empty sentinel stops the backward walk before tape underflow
<<[
  <.
  >[-]
  <<<
]

# END reversed command stream
