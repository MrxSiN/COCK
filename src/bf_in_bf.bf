# MODULE initial BF in BF arithmetic evaluator
# PURPOSE execute the admitted arithmetic guest command stream as data
# INPUT exact normalized arithmetic program with one final output command
# OUTPUT one byte from the emulated guest cell
# TAPE cell zero incoming source command
# TAPE cell one plus flag
# TAPE cell two command residue
# TAPE cell three minus flag
# TAPE cell four emulated guest byte
# LIMITATION no dynamic pointers loops guest input or compiler self execution yet
# PRECONDITION exact source preflight and trusted source closure are external gates

,[
  # Map an ASCII plus instruction onto zero
  -------------------------------------------
  >+<
  [->>+<[-]<]

  # Advance the emulated guest cell for a plus command
  >[>>>+<<<-]

  # Identify the minus command without changing a final output command
  >--
  >+<
  [[-]>[-]<]
  >[> -<-]

  # Continue reading the already admitted source stream
  <<<,
]

# The single terminal guest output is deferred until source closure
>>>>.

# END arithmetic evaluator
