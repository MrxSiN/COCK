# MODULE raw subset gate
# PURPOSE validate a bounded raw source record before any guest work
# INPUT byte count then exact source bytes then required completion guard
# OUTPUT byte one means accepted and byte zero means rejected
# TAPE cell zero count of unread source bytes
# TAPE cell one current input byte and completion guard
# TAPE cell two arithmetic addition classifier
# TAPE cell three arithmetic subtraction classifier
# TAPE cell four final output classifier
# TAPE cell five rejection accumulator
# TAPE cell six final output observed flag
# TAPE cell seven emulated arithmetic value
# TAPE cell eight recognized command flag
# TAPE cell nine conditional scratch flag
# TAPE cell ten saved final output flag
# CONTRACT explicit per invocation input byte budget of at most 255
# CONTRACT host must attest actual byte count and successful stream close
# LIMITATION raw source subset only with no annotated module syntax
# LIMITATION printable output admission belongs to a later gate
# LIMITATION successful byte alone is not authoritative transport closure

# Acquire declared source length and process exactly that many source bytes
,[
  -

  # Mark all input after an already seen final output as invalid
  >>>>>>[->>>+>+<<<<]>>>[<<<+>>>-]>[<<<<<[-]+>>>>>-]<<<<<<<<<<

  # Copy the current byte for three independent exact classifiers
  >,
  [->+>+>+<<<]
  >-------------------------------------------
  >---------------------------------------------
  >----------------------------------------------
  <<

  # Convert addition equality into a one byte Boolean flag
  >>>>>>>+<<<<<<<
  [->>>>>>>[-]<<<<<<<]
  >>>>>>>[<<<<<<<+>>>>>>>-]<<<<<<<

  # Convert subtraction equality into a one byte Boolean flag
  >
  >>>>>>+<<<<<<
  [->>>>>>[-]<<<<<<]
  >>>>>>[<<<<<<+>>>>>>-]<<<<<<

  # Convert final output equality into a one byte Boolean flag
  >
  >>>>>+<<<<<
  [->>>>>[-]<<<<<]
  >>>>>[<<<<<+>>>>>-]<<<<<
  <<

  # Apply the identified arithmetic without emitting guest effects
  [->>>>>>+<+<<<<<]
  >[->>>>>+<-<<<<]
  >[->>>>+<<+<<]

  # Reject every other command including zero input bytes
  >>>>
  >+<
  [->[-]<]
  >[<<<<[-]+>>>>-]<
  <<<<<<<<
]

# The terminal guard is decimal 165 and detects EOF filled zero tails
>,
>+++++++++++[<--------------->-]<
[->>>>[-]+<<<<]
<

# Reject a source with no final output command
>>>>>>
>>>+<<<
[->>>[-]<<<]
>>>[<<<<[-]+>>>>-]
<<<<<<<<<

# Output a single provisional Boolean admission result
>>>>>
>+<
[->[-]<]
>.

# END raw subset gate
