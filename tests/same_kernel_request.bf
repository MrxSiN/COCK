# MODULE same reference kernel nested compiler request
# PURPOSE serialize identical inner interpreter and real compiler execution
# INPUT interpreter chunks then zero compiler chunks then zero input chunks then zero
# INPUT each positive chunk count is one byte followed by that many literal bytes
# OUTPUT interpreter source then bang then compiler source then bang then binary input
# TAPE zero is remaining chunk count and separator printer one is literal byte
# REQUIREMENT both source streams independently admitted and normalized before use
# REQUIREMENT immutable complete input and output counts and host closure checked outside
# LIMITATION diagnostic transport only with no source admission or success certificate
# LIMITATION malformed or truncated input must be vetoed by independent physical counts
# LICENSE this transport is project authored and the interpreter is separately attributed

# Copy the exact inner interpreter source from counted chunks
,[
  [>,.<-]
  ,
]

# Separate inner source from the request it will consume
+++++++++++++++++++++++++++++++++.
[-]

# Copy the exact compiler source from counted chunks
,[
  [>,.<-]
  ,
]

# Separate the real compiler source from its binary input
+++++++++++++++++++++++++++++++++.
[-]

# Preserve all input bytes including zero bang and the full byte value
,[
  [>,.<-]
  ,
]

# END the host independently authenticates complete process and stream closure
