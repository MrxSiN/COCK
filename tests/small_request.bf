# MODULE small reference interpreter request serializer
# PURPOSE route common profile cases to the preserved independent BF reference
# INPUT source count in two bytes fuel in four capacity in two guest count in two
# INPUT exact normalized source then exact guest input
# OUTPUT one byte source count source one byte fuel one byte capacity then guest input
# PRECONDITION source count fuel and capacity fit the admitted reference profile
# TAPE ten retains fuel and eleven capacity while source is copied
# LIMITATION diagnostic comparison route not a general narrowing conversion

,>,>,>,>,>,>,>,>,>,
<<<<<<<[->>>>>>>>+<<<<<<<<]
>>>>[->>>>>+<<<<<]
<<<<<<.>>[-]>[-]>[-]>[-]>[-]
<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-[->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]
>>>>.>.<<<[-<<<<<<<<+>>>>>>>>]>[-<<<<<<<<+>>>>>>>>]<<<[-]
<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
<<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
[
  [-]<<<<,.<<-[->>>+>+<<<<]>>>>[-<<<<+>>>>]<+
  >>+<<[[-]>>[-]<<]>>[[-]<<<<->>>>]
  >[-]<<<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]<[[-]>>>[-]+<<<]
  <<[->>+>+<<<]>>>[-<<<+>>>]<[[-]>>>[-]+<<<]>>>
]
