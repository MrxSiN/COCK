# MODULE independent arithmetic oracle
# PURPOSE evaluate one normalized arithmetic guest source stream
# INPUT exact admitted arithmetic commands and one final output command
# OUTPUT one unsigned guest byte
# TAPE cell zero source character
# TAPE cell one reference guest accumulator
# TAPE cell two minus operation flag
# TAPE cell three residue from ASCII minus
# TAPE cell four plus operation flag
# METHOD recognize minus first then plus with modular ASCII residues
# LIMITATION this is not the complete independent COCK trace oracle

,[
  # Convert ASCII minus into zero and plus into unsigned residue
  ---------------------------------------------

  # A zero residue identifies subtraction from the guest cell
  >>+<<
  [->>>+<[-]<<]
  >>[<->-]

  # Adding two to the residue identifies ASCII plus by modular wrap
  >++
  >+<
  [[-]>[-]<]
  >[<<<+>>>-]

  # Acquire the next source character
  <<<<,
]

# Emit the checked guest byte exactly once
>.

# END reference arithmetic oracle
