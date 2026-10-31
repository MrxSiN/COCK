# MODULE trusted BF source instruction decoder
# AUTHOR ASCII decoder by Daniel B Cristofani
# CREDIT original paper with Oleg Mazonka and original dbfi license retained
# INPUT normalized admitted source followed by bang with no guest input
# OUTPUT exact instruction codes one through eight and terminal zero
# CODES close open right left output minus input plus in ascending code order
# TAPE original contiguous decoded instructions and original parser scratch
# REQUIREMENT balanced source immutable identity and independent physical closure
# LIMITATION no source grammar error offset or production transport authority
# ADAPTATION original dbfi decoder followed by BF code serialization
>>>+[[-]>>[-]++>+>+++++++[<++++>>++<-]++>>+>+>+++++[>++>++++++<<-]+>>>,<++[[>[->>]<[>>]<<-]<[<]<+>>[>]>[<+>-[[<+>-]>]<[[[-]<]++<-[<+++++++++>[<->-]>>]>>]]<<]<]<
# Return to first decoded code and serialize every instruction plus zero
[<]>[.>].
