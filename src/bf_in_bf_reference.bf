# MODULE independently authored Brainfuck self interpreter reference
# PURPOSE test actual guest Brainfuck source through an existing BF layer
# ORIGINAL AUTHOR Daniel B Cristofani
# ORIGINAL SOURCE brainfuck dot org slash dbfi dot b
# LICENSE Creative Commons Attribution ShareAlike 4 point 0
# ADAPTATION Added these safe annotations and line breaks only
# INPUT Guest BF program then ASCII bang separator then guest input bytes
# OUTPUT Raw guest output bytes
# TAPE The reference implementation owns its internal layout
# STATUS Diagnostic reference only and not COCK profile conformance
# LIMITATION Trusted input closure and preflight are not implemented here

>>>+[[-]>>[-]++>+>+++++++[<++++>>++<-]++>>+>+>+++++[>++>++++++<<-]+>>>,<++[[>[
->>]<[>>]<<-]<[<]<+>>[>]>[<+>-[[<+>-]>]<[[[-]<]++<-[<+++++++++>[<->-]>>]>>]]<<
]<]<[[<]>[[>]>>[>>]+[<<]<[<]<+>>-]>[>]+[->>]<<<<[[<<]<[<]+<<[+>+<<-[>-->+<<-[>
+<[>>+<<-]]]>[<+>-]<]++>>-->[>]>>[>>]]<<[>>+<[[<]<]>[[<<]<[<]+[-<+>>-[<<+>++>-
[<->[<<+>>-]]]<[>+<-]>]>[>]>]>[>>]>>]<<[>>+>>+>>]<<[->>>>>>>>]<<[>.>>>>>>>]<<[
>->>>>>]<<[>,>>>]<<[>+>]<<[+<<]<]

# END third party reference interpreter
