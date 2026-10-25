# MODULE legacy fixture adapter for the wide kernel
# PURPOSE preserve stored compiler requests while extending fuel and adding capacity
# INPUT two byte payload count and two byte capacity then old four byte header
# INPUT exactly payload count bytes remaining from the stored legacy fixture
# OUTPUT new eight byte header and the unchanged source and guest payload
# TAPE zero and one payload count two through seven saved header
# TAPE twelve emits the two added zero fuel bytes
# LIMITATION diagnostic adapter only with externally established exact file lengths

,>,>,>,>,>,>,>,
<<<.>.>.>.>>>>>[-]..<<<<<<<<<<.>.
[-]<[-]>>[-]>[-]>[-]>[-]<[-]
<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-[->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]
