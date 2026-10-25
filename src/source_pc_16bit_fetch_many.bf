# MODULE indexed source fetch on sixteen bit command positions
# PURPOSE retrieve instruction at source program counter after buffering source
# INPUT exact normalized source bytes then a zero source terminator
# INPUT one byte query count then sixteen bit little endian query positions
# OUTPUT each query opcode followed by a status byte
# OUTPUT success status zero and missing opcode status thirteen
# TAPE one source record stores opcode and three temporary byte cells
# TAPE four host cells per record grow with the actual source
# LIMITATION terminator is a diagnostic input convention requiring trusted closure
# LIMITATION source grammar and bracket preflight remain separately required
# LIMITATION query count is a one byte diagnostic per invocation budget
# LIMITATION no guest instruction execution occurs in this component

>>>>>>>>>>>>>>>>,[>>>>,]<<<<[<<<<]>>>><<<<<<<<<<<<<<<<,[>,>,>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<[->>>>
>>>>>>>>>>>>+<<<<<<<<<<<<<<<<]>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<[->>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<
<]>>>>>>>>>>>>>>>>>>>[-]>[-]<<<<<[->>>>+>+<<<<<]>>>>>[-<<<<<+>>>>>]<[[-]<<[-]+>>][-]>[-]<<<<[->>>+>+
<<<<]>>>>[-<<<<+>>>>]<[[-]<<[-]+>>]<<[[-]+>>[-]<<<<[->>>>+<<<<]>>>>>[-]<<<<[->>>>+<<<<]<[-]>[-]>>>[-
<<<<+>+>>>]<<<[->>>+<<<]>[-]+<<[[-]>>[-]<<]>>[->>>-<<<]+>>-<<<<[-]>[-]>>>[-<<<<+>+>>>]<<<[->>>+<<<]<
[[-]>>>>>>[-]+<<<<<<][-]>[-]>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]<[[-]>>>>>>[-]+<<<<<<]>>>>>>]<<[-]>[-
]<<[->+>+<<]>>[-<<+>>]>[-]+<<[[-]>>[-]<<][-]>>[-<<+++++++++++++>>]<<<.>.<<[-<<<<]><<<<<<<<<<<<<<<<-]

# END source fetch
