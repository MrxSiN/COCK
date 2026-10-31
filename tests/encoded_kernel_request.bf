# MODULE encoded nested request literal transport
# PURPOSE copy three independently counted chunk streams in their exact order
# INPUT three positive byte count chunk sequences each terminated by zero count
# OUTPUT unaltered bodies of all three streams without added separators
# TAPE cell zero chunk count and cell one byte scratch
# REQUIREMENT encoded source bodies already contain their zero instruction marker
# LIMITATION physical source identity exact counts and closure are external facts

# Copy first encoded interpreter body
,[ [->,.<] ,]
# Copy second encoded compiler body
,[ [->,.<] ,]
# Copy raw compiler request including all binary bytes
,[ [->,.<] ,]
