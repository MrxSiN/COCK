# MODULE printable subset gate
# PURPOSE validate raw subset source and printable computed guest byte
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
# TAPE cell eleven disposable arithmetic value
# TAPE cell twelve remaining lower range threshold
# TAPE cell thirteen lower threshold scratch
# TAPE cell fourteen remaining upper range threshold
# TAPE cell fifteen upper threshold scratch
# CONTRACT explicit per invocation input byte budget of at most 255
# CONTRACT host must attest actual byte count and successful stream close
# LIMITATION raw source subset only with no annotated module syntax
# CONTRACT admitted guest byte must be printable ASCII inclusive space through tilde
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

# Examine the emulated modulo byte without losing its original value
>>>>>>>[->>>>+>+<<<<<]>>>>>[<<<<<+>>>>>-]<

# Lower limit is thirty two and upper exclusive limit is one hundred twenty seven
>++++++++++++++++++++++++++++++++
>++++++++[>++++++++++++++++<-]>-
<<<

# Consume one byte count while saturating both comparison thresholds
[
  -
  >[-[->+<]]>[<+>-]<
  >>[-[->+<]]>[<+>-]<
  <<<
]

# Remaining lower threshold means byte is less than the printable minimum
>[<<<<<<<+>>>>>>>-]

# Zero remaining upper threshold means byte reached the excluded upper bound
>>
>+<
[->[-]<]
>[<<<<<<<<<<+>>>>>>>>>>-]
<<<<<<<<<<<<<<<

# Output a single provisional Boolean admission result
>>>>>
>+<
[->[-]<]
>.

# END raw subset gate
