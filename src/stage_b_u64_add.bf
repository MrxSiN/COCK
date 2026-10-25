# MODULE checked unsigned sixty four bit addition
# PURPOSE add two full width little endian unsigned integers in BF
# INPUT eight bytes A then eight bytes B then hexadecimal A5 guard
# OUTPUT status zero then eight sum bytes on success
# OUTPUT status ten on overflow or eleven on invalid guard
# TAPE records begin at eight with stride eight
# TAPE record zero A one B two sum three and five copy scratch
# TAPE record four carry six control and seven unused
# TAPE eighty status eighty one admission eighty two output gate
# PROFILE unsigned wrapping byte cells with zero at EOF
# REQUIREMENT independent exact seventeen byte count and physical close
# LIMITATION guard cannot authenticate trailing byte absence

# Read eight bytes of the first operand
>>>>>>>>,
>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,

# Read eight bytes of the second operand
<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
>,
>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,>>>>>>>>,

# Read and check the final guard before any result output
<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
,
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----
>>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>>
+
<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
[
  [-]
  >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>> >>>>>>>
  +++++ +++++ +>[-]
  <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
]

# Mark exactly eight byte records for the arithmetic pass
>>>>>>>> >>>>>+
>>>>>>>>+>>>>>>>>+>>>>>>>>+>>>>>>>>+>>>>>>>>+>>>>>>>>+>>>>>>>>+
<<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
[
  [-]<<<<<<

  # Start sum with the first operand byte
  [->>+<<]

  # Add incoming carry with checked byte rollover
  >>>>[
    -<<
    +[->+>>+<<<]>>>[-<<<+>>>]>+<<<[[-]>>>[-]<<<]>>>
    [[-]>>>>>>[-]+<<<<<<]<<<<
    >>
  ]

  # Add the second operand byte and propagate unsigned rollover
  <<<[
    ->
    +[->+>>+<<<]>>>[-<<<+>>>]>+<<<[[-]>>>[-]<<<]>>>
    [[-]>>>>>>[-]+<<<<<<]<<<<
    <
  ]
  >>>>> >>>>>>>>
]

# Guard failure takes precedence over arithmetic overflow
>>>[
  [-]>+<<<<<<
  [[-]>>>>+++++ +++++>>[-]<<<<<<]
  >>>>>
]
<.

# Publish all eight result bytes only for an admitted nonoverflowing sum
>>[
  [-]
  <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<< <<<<<<<<
  .>>>>>>>>.>>>>>>>>.>>>>>>>>.>>>>>>>>.>>>>>>>>.>>>>>>>>.>>>>>>>>.
  >>>>>>>> >>>>>>>>
]

# END exact checked arithmetic component
