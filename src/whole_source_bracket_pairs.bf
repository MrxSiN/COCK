# MODULE COCK whole stream bracket pair emitter
# PURPOSE emit original command position pairs for all nested loops in one run
# INPUT independently admitted normalized BF bytes then one zero terminal marker
# INPUT independent exact read count and successful host closure are required
# OUTPUT for each closed loop open low high and close low high then one status byte
# TAPE sixteen outer cells per live bracket stack frame with mobile execution cursor
# PROFILE source offsets are zero based unsigned sixteen bit original command positions
# PROFILE status zero success two unmatched open three unmatched close ten overflow
# LIMITATION early emitted pairs are provisional until final status and host closure
# LIMITATION no guest execution and no original annotated source byte offsets
# LIMITATION zero marker is safe only after trusted complete source preflight

# Initialize root frame marker and root flag
+>>>>>>>>>>>>>+
# Loop over admitted normalized command bytes until zero terminator
<<<<<<<<<<<<<[>[-],
# Zero terminator closes the source and requires an empty bracket stack
>[-]>[-]<<[->+>+<<]>>[-<<+>>]>>>>>>>[-]+<<<<<<<<[[-]>>>>>>>>[-]<<<<<<<<]>>>>>>>>[[-]<<<<<<
<<<<>>>>>>>>[-]>[-]>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]>>>>>[-]+<<<<<<[[-]>>>>>>[-]<<<<<<]>
>>>>>[[-]<<<<<<<<<<<<<<>>>>>>>>>>>[-]++>>>]<<<<<<<<<<<<<<[-]>>>>>>>>>>]
# Match opening command and push saved source offset onto dynamic frame stack
# Check opening and closing bracket commands
>>[-]<<<<[-]<<<<<<<<[->>>>>>>>>>>>+<<<<+<<<<<<<<]>>>>>>>>[-<<<<<<<<+>>>>>>>>]>>>>[[-]<<<<<
<<<<<<<>>[-]>[-]<<[->+>+<<]>>[-<<+>>]<----------------------------------------------------
--------------------------------------->>>>>>>>[-]+<<<<<<<<[[-]>>>>>>>>[-]<<<<<<<<]>>>>>>>
>[[-]<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<[-]<<<<[->>>>>>>>>>>>>>>>+<<<<<<<<<<<<+<
<<<]>>>>[-<<<<+>>>>]>>>>>>>>>>>>>[-]<<<<<<<<<<<<<[-]<<<[->>>>>>>>>>>>>>>>+<<<<<<<<<<<<<+<<
<]>>>[-<<<+>>>]>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<[-]<<<<[->>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<+<
<<<]>>>>[-<<<<+>>>>]>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<[-]<<<[->>>>>>>>>>>>>>>>>>+<<<<<<<<<<
<<<<<+<<<]>>>[-<<<+>>>]>>>>>>>>>[-]<+>>>>>>>>>>>>>>>><<<<<<]<<<<<<<<[-]>[-]<<[->+>+<<]>>[-
<<+>>]<-----------------------------------------------------------------------------------
---------->>>>>>>>[-]+<<<<<<<<[[-]>>>>>>>>[-]<<<<<<<<]>>>>>>>>[[-]<<<<<<<<<<>>>>>>>>[-]>[-
]>>>>[-<<<<<+>+>>>>]<<<<[->>>>+<<<<]>>>>>[-]<<<<<<[[-]>>>>>>+<<<<<<]>>>>>>[[-]<<<<<<<<<<<<
<<>>>>>>>>>>>[-]+++<<<<<<<<<<<[-]>>>>>>>>>>>>>>]<<<<<<[-]>[-]>>>>[-<<<<<+>+>>>>]<<<<[->>>>
+<<<<]>>>>>[-]+<<<<<<[[-]>>>>>>[-]<<<<<<]>>>>>>[[-]<<<<<<<<<<<<<<>>>>>>.>.<<<.>.<<<<<<<<<<
<<<<<<<[-]>>>>>>>>>>>>>>>>>>>>[-]<<<<[-<<<<<<<<<<<<<<<<+>>>>>>>>>>>>>>>>>>>>+<<<<]>>>>[-<<
<<+>>>>]<<<<<<<<<<<<<<<<<<<[-]>>>>>>>>>>>>>>>>>>>[-]<<<[-<<<<<<<<<<<<<<<<+>>>>>>>>>>>>>>>>
>>>+<<<]>>>[-<<<+>>>]<<<<<<<<[-]<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>]<<<<]
# Advance checked sixteen bit command position
<<<<<<+<<[-]>[-]>[-<<+>+>]<[->+<]>>>>>>>[-]+<<<<<<<<[[-]>>>>>>>>[-]<<<<<<<<]>>>>>>>>[[-]<<
<<<<<<<<>>>>>+>>>[-]>[-]<<<<[->>>+>+<<<<]>>>>[-<<<<+>>>>]>>>>>[-]+<<<<<<[[-]>>>>>>[-]<<<<<
<]>>>>>>[[-]<<<<<<<<<<<<<<>>>>>>>>>>>[-]++++++++++<<<<<<<<<<<[-]>>>>>>>>>>>>>>]<<<<]>>]<<<
<<<<<<<<<]
# Emit single terminal diagnostic status byte
>>>>>>>>>>>.
