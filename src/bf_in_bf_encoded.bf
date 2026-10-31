# MODULE BF trusted tool execution kernel with decoded input
# PURPOSE execute complete BF authored tools using prepared instruction records
# AUTHOR execution loop by Clive Gifford December two thousand six
# INPUT existing virtual instruction codes followed by zero then guest input
# OUTPUT exact raw guest output bytes with no authority or completion added
# TAPE first instruction at seven and consecutive instruction records use pairs
# TAPE two zero cells separate program end from first data marker and zero value
# PRECONDITION records produced by the BF source decoder from admitted tool source
# PRECONDITION wrapping bytes zero EOF balanced loops and no pointer underflow
# LIMITATION this execution loop is one part of a split BF source interpreter
# LIMITATION host watchdog and independent physical closure remain required
# ADAPTATION BF record reader followed by unchanged original execution loop
# Load each prepared instruction into its original paired record
>>>>>>>,[>>,]
# Mark the first zero initialized guest cell and return to first instruction
>>+<<<<[<<]>>
# Execute prepared instructions with the original BF algorithm
[
[<+>>+<-]
+<-
[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-[
-
>->> [>>] >> [>>]< [<-<<-<] <[<<] << [<<]<
]
>[->> [>>] >> [>>]< [>+>>+>] <[<<] << [<<]]<
]
>[->> [>>] >> [>>] <[-]< [<<] << [<<]]<
]
>[->> [>>] >> [>>]< [<-<] <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< [>+>] <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< <-<<-< <[<<] << [<<]]<
]
>[->> [>>] >> [>>] +>>+ [<<] << [<<]]<
]
>[->> [>>] >> [>>]< ++ <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< + <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< , <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< - <[<<] << [<<]]<
]
>[->> [>>] >> [>>]< . <[<<] << [<<]]<
]
>[->> [>>] >> [>>] <<-<< [<<] << [<<]]<
]
>[->> [>>] >> [>>] + [<<] << [<<]]<
]
>
[-
>> [>>] >> [>>]<
[>+>>+<<<-]>
[<+>-]
>>[<<+>>[-]]+
<<[>>-<<-]
>>
[<<+>>>>+<<-]
>>[<<+>>-]
<<[>>+<<-]+
>>[<<->>-]<<
<<
[
-<< [<<] << [<<]<
<< << ++
>>
]
>>
[-<<<<<<[<<]<<[<<]<]
>
]
<
]
>
[-
>> [>>] >> [>>]<
[>+>>+<<<-]>
[[<+>-]>>[-]+<<]
>>
[<<+>>>>+<<-]
>>[<<+>>-]
<<[>>+<<-]+
>>[<<->>-]<<
<<
[
-<< [<<] << [<<]<
<< << +
>>
]
>>
[-<<<<<<[<<]<<[<<]<]
>
]
>[<+>-]
<< << <<
[
>> +
<< -
[
- >> - >> +
[
>>>[-<+>>+<]
+<-
[
-[
[-]
> - <
]
> [- <<< + >>>] <
]
> [- <<< - >>>]
>[-<+>]<<
<<
[>>+<<-]
>>
]
<< << <<
]
>>
[
- << +
[
>>>[-<+>>+<]
+<-
[
-[
[-]
> - <
]
> [- <<< - >>>] <
]
> [- <<< + >>>]
>[-<+>]<<
<<
[<<+>>-]
<<
]
]
]
>> >> >>
>
]
