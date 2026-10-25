# MODULE counted same kernel nested compiler request
# PURPOSE serialize interpreter compiler and application input without aggregate counts
# INPUT outer fuel four bytes outer capacity two inner fuel four inner capacity two
# INPUT interpreter count two compiler count two application input count two
# INPUT exact interpreter bytes then compiler bytes then application input bytes
# OUTPUT outer request containing the inner interpreter and real compiler request
# TAPE zero anchor one through eighteen retain the recipe header
# TAPE twenty and twenty one remaining count twenty two payload byte
# TAPE twenty three and twenty four scratch twenty five borrow twenty six loop
# PROFILE wrapping byte cells binary input and zero at EOF
# LIMITATION supplied physical counts and complete read and close are external duties
# LIMITATION source admission process success and closure are not certified here
# LIMITATION no success status is emitted and partial stdout remains provisional

# Retain the complete fixed recipe header
>,>,>,>,>,>,>,>,>,>,>,>,>,>,>,>,>,>,

# Emit interpreter length followed by outer fuel and capacity
<<<<<.>.
<<<<<<<<<<<<<.>.>.>.>.>.

# Move interpreter count to the common copy counter
>>>>>>>[->>>>>>>+<<<<<<<]
>[->>>>>>>+<<<<<<<]
>>>>>>

# Set continuation when either remaining count byte is nonzero
[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-
  [->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]

# Emit compiler length followed by inner fuel and capacity
<<<<<<<<<<<.>.
<<<<<<<<<.>.>.>.>.>.

# Move compiler count to the same copy counter
>>>[->>>>>+<<<<<]
>[->>>>>+<<<<<]
>>>>

# Copy compiler bytes with a two byte remaining count
[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-
  [->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]

# Move application input count to the same copy counter
<<<<<<<<<[->>>+<<<]
>[->>>+<<<]
>>

# Copy application input including zero and full byte values
[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-
  [->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]

# END complete provisional request with no terminal certificate
