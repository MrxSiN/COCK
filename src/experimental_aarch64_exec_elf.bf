# MODULE exploratory Linux AArch64 executable ELF emitter
# PURPOSE wrap already BF generated AArch64 return function as an executable ELF
# INPUT unsigned sixteen bit little endian native byte count then exact raw bytes
# OUTPUT native AArch64 Linux executable ELF64 binary on trusted complete input
# TAPE zero and one input length two and three file length low words
# TAPE four constant add loop five and six scratch seven carry test
# TAPE eight and nine remaining native byte count ten overflow high and input
# TAPE eleven literal printer twelve to fourteen copy loop scratch
# PRECONDITION supplied native byte stream ends in AArch64 return and is valid
# PRECONDITION root host independently checks exact physical lengths and close
# LIMITATION Linux syscall ninety three not Android NativeActivity callback
# LIMITATION no opcode check payload trust no atomic output on read failure
# LIMITATION diagnostic only not accepted Stage A build or Android release
# PROVENANCE BF emission logic and arithmetic handwritten literal header transcribed mechanically
# READ two input length bytes
,>,
# DUPLICATE declared byte lengths for ELF size and copy counter
<[->>+>>>>>>+<<<<<<<<]>[->>+>>>>>>+<<<<<<<<]>
# ADD one hundred thirty two to file size and account for byte carries
>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++
[ - << + [->>>+>+<<<<] >>>> [-<<<<+>>>>] >[-]+ <<[[-]>>[-]<<] >>
[ - <<<< + [->>+>+<<<] >>> [-<<<+>>>] >[-]+ <<[[-]>>[-]<<] >> [ - >>>+<<< ] ] <<< ]
# EMIT ELF HEADER and one executable load segment using BF literal writes
>>>>>>>
# ELF identity and canonical target header
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++.
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
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++.
--------------------------------------------------------------------------------------------
----------------------------.
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
# Program header fields before segment file length
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
# FILE SIZE unsigned twenty four bit derived by BF from native body length
<<<<<<<<<.>>>>>>>>>
<<<<<<<<.>>>>>>>>
<.>
.
.
.
.
.
# MEMORY SIZE same independently emitted BF computed size
<<<<<<<<<.>>>>>>>>>
<<<<<<<<.>>>>>>>>
<.>
.
.
.
.
.
# Page load alignment and Linux syscall entry wrapper
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
--------------------------------------------------------------------------------------------
----------------.
++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++.
-.
.
--------------------------------------------.
# COPY EXACT declared native bytes with low remainder then high blocks
<<<
[->>,.<<]
>[-<-[->>,.<<]>>,.<<>]
# END provisional ELF64 host diagnostic generator
