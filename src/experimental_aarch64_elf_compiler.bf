# MODULE restricted one program BF native Linux ELF compiler diagnostic
# PURPOSE BF only source derived AArch64 executable with no foreign code generator
# INPUT first normalized arithmetic program ended by a zero byte
# INPUT the same previously admitted program repeated until physical EOF zero
# OUTPUT executable ELF64 AArch64 using Linux syscall exit as observation
# SOURCE only addition subtraction and a single final output operation admitted
# PRECONDITION independent annotated preflight subset and two copy identity
# PRECONDITION root tool checks exact input source closure bytes and processes
# NATIVE emits four bytes for each admitted arithmetic source operation
# NATIVE emits a zero initial register and final byte truncation and return
# ELF size calculated by this BF program from the first source copy
# LIMITATION unqualified root no physical input closure no nested proof
# LIMITATION three byte file size and no Android NativeActivity ABI
# LIMITATION this is diagnostic and not a Stage A Android compiler
# PROVENANCE BF semantics reuse the unchanged compact BF native compiler
# TAPE cell zero source current two three four computed ELF file byte length
# TAPE cells six and seven carry flags eight overflow nine emission gate
# TAPE cells ten eleven scratch and twenty literal native header printer
# INITIALIZE fixed one hundred forty byte ELF and native overhead
>>
-----------------------------------------------------------------------------------------------
---------------------
<<
# FIRST PASS count all prevalidated normalized commands through zero terminator
,[
>>
++++
[->>>>>>>>+>+<<<<<<<<<]
>>>>>>>>>
[-<<<<<<<<<+>>>>>>>>>]
<<<<<
[-]+
>>>>
[[-]<<<<[-]>>>>]
<<<<
[
[-]
<<<
+
[->>>>>>>+>+<<<<<<<<]
>>>>>>>>
[-<<<<<<<<+>>>>>>>>]
<<<<
[-]+
>>>
[[-]<<<[-]>>>]
<<<
<
]
>
[
[-]
<<<
+
[->>>>>>+>+<<<<<<<]
>>>>>>>
[-<<<<<<<+>>>>>>>]
<<<
[-]+
>>
[[-]<<[-]>>]
<<
<
]
<<<<<<<
,
]
# ERROR if declared diagnostic ELF size overflows twenty four byte bits
>>>>>>>>>
[-]+
<
[
[-]
>
[-]
<<<<<<<<<
.
>>>>>>>>
]
>
[
[-]
# BEGIN successful ELF header emission all literal bytes and lengths BF produced
>>>>>>>>>>>
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++.
----------------------------------------------------------.
+++++++.
------.
--------------------------------------------------------------------.
-.
.
-.
.
.
.
.
.
.
.
.
++.
--.
-------------------------------------------------------------------------.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+.
-.
.
.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++.
-----------------------------------------------------------------------------------------------
-------------------------.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
----------------------------------------------------------------.
.
.
.
.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
----------------------------------------------------------------.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
----------------------------------------------------------------.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
--------------------------------------------------------.
+.
-.
.
.
.
.
.
.
+.
-.
.
.
+++++.
-----.
.
.
.
.
.
.
.
.
.
.
.
.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
----------------------------------------------------------------.
.
.
.
.
.
.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
----------------------------------------------------------------.
.
.
.
.
# OUTPUT exact BF calculated program file length in little endian twice
<<<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>>>
<<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>>
<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>
.
.
.
.
.
<<<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>>>
<<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>>
<<<<<<<<<<<<<<<<
.
>>>>>>>>>>>>>>>>
.
.
.
.
.
.
++++++++++++++++.
----------------.
.
.
.
.
.
+++.
---.
.
-----------------------------------------------------------------------------------------------
-------------.
++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++.
-.
.
--------------------------------------------.
# CLEAR writer registers so appended BF native compiler starts with zero tape
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
<
[-]
# SECOND PASS compile same normalized source to inline native AArch64 words
# MODULE compact arithmetic AArch64 compiler
# PURPOSE emit source dependent native arithmetic words with one final byte reduction
# INPUT trusted normalized plus and minus commands followed by one output command
# OUTPUT raw little endian AArch64 words and no ELF container
# TAPE cell zero input command
# TAPE cell one plus classification flag
# TAPE cell two minus command residue
# TAPE cell three minus classification flag
# TAPE cell four output constant scratch
# TAPE cell five constant multiplier scratch
# PRECONDITION independently validated complete guest source and host closure
# LIMITATION loop free no input single cell and no guest fuel
# CONTRACT each arithmetic command emits one native instruction
# CONTRACT one final modulo byte operation preserves the admitted guest result

# Emit zero initialization of native return register
>>>>
..
++++++++[>++++++++++++++++<-]>.[-]<
++++++++[>++++++++++<-]>++.[-]<
<<<<

# Read each validated arithmetic command until physical input ends
,[
  # Normalize ASCII addition to zero
  -------------------------------------------

  # Classify addition without losing the subtraction residue
  >+<
  [->>+<[-]<]

  # Emit one AArch64 register addition by one
  >[
    >>>
    .++++.[-].+++++++++++++++++.[-]
    <<<-
  ]

  # Classify subtraction using the remaining source residue
  >--
  >+<
  [[-]>[-]<]

  # Emit one AArch64 register subtraction by one
  >[
    >
    .++++.[-].
    +++++[>++++++++++++++++<-]>+.[-]
    <<-
  ]

  # Read next validated command
  <<<,
]

# Emit one final extraction of the low unsigned byte
>>>>
.++++++++++++++++++++++++++++.[-].
++++++++[>++++++++++<-]>+++.[-]<

# Return through the native platform calling convention
++++++++++++[>++++++++++++++++<-]>.[-]<
+++.[-]
+++++++++[>++++++++++<-]>+++++.[-]<
++++++++++++++++++++[>++++++++++<-]>++++++++++++++.[-]<

# END compact raw native generator
>>>>>
]
# END single BF source to Linux ELF compilation path
