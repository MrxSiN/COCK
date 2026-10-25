# MODULE independent counted binary comparison
# PURPOSE compare literal expected bytes with actual bytes including zero
# INPUT expected count in two bytes expected data actual count in two bytes actual data
# OUTPUT zero for equality or one for mismatch
# TAPE anchor one and two expected length three mismatch four and five actual length
# TAPE records begin at eight with stride eight
# TAPE record zero backlink one expected byte two consumed prefix three input scratch
# TAPE record four and five remaining count six copy scratch seven loop flag
# LIMITATION host supplied byte counts and physical closure remain prerequisites

>,>,<
[->>>>>>>>>>>+<<<<<<+<<<<<]>>>>>[-<<<<<+>>>>>]
<<<<[->>>>>>>>>>>+<<<<<<<+<<<<]>>>>[-<<<<+>>>>]
>>[-]+>>>>>>>

# Test the mobile expected count
<<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
<[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
[
  [-]<<<<<<,
  >>>-[->>+<<<+>]<[->+<]>>>+>+<[[-]>[-]<]>
  [[-]<<->>]
  <<<[->>>>>>>>+<<<<<<<<]>[->>>>>>>>+<<<<<<<<]
  >>>>>>>><<<<<[-]+>>>>>>>
  <<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
  <[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
]
<<<<<<<[<<<<<<<<]>>>>,>,

# Compare the two declared lengths before comparing contents
<[->>+>+<<<]>>>[-<<<+>>>]<[-<<<<<->>>>>]
<[->+>+<<]>>[-<<+>>]<[-<<<<->>>>]
<<<<<[[-]>>[-]+<<]>[[-]>[-]+<]
>>[->>>>>>>>+<<<<<<<<]>[->>>>>>>>+<<<<<<<<]
>>>>>>>> >>
<<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
<[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
[
  [-]<<<<,[-<<->>]<<[
    [-]<[<<<<<<<<]>>>[-]+<<[-]
  ]
  <[<<<<<<<<]>>>>>>>> >>[>>>>>>>>]+
  >>-[->>+<<<+>]<[->+<]>>>+>+<[[-]>[-]<]>
  [[-]<<->>]
  <<<[->>>>>>>>+<<<<<<<<]>[->>>>>>>>+<<<<<<<<]
  >>>>>>>><<<<<[-]+>>>>>>>
  <<<[->>+<<<+>]<[->+<]>>>[[-]>[-]+<]
  <[->+<<<+>>]<<[->>+<<]>>>[[-]>[-]+<]>
]
<<<<<<<[<<<<<<<<]>>>.
