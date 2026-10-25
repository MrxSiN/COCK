# MODULE BF owned nested reference transport driver
# PURPOSE create a diagnostic input for an interpreting BF reference host
# INPUT source chunks each with a positive one byte count and literal source bytes
# INPUT zero source count then binary input chunks and final zero count
# OUTPUT the exact source stream then ASCII bang then exact input stream
# TAPE cell zero stores current remaining count and the delimiter constant
# TAPE cell one stores each literal byte until emitted
# PRECONDITION independently admitted complete source and trusted transport closure
# LIMITATION packet closure and source validation are outside this diagnostic driver
# LIMITATION this emits transport bytes and does not execute or compile application logic

# Copy every source chunk byte without changing its value
,[
  [>,.<-]
  ,
]

# Write the separator required by the independently attributed reference interpreter
+++++++++++++++++++++++++++++++++.
[-]

# Copy binary input including zero and full byte values using declared chunk counts
,[
  [>,.<-]
  ,
]

# END diagnostic transport construction
