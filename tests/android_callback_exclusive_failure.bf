# MODULE bounded callback exclusive failure diagnostic adapter
# PURPOSE force every store exclusive to fail without acquiring a reservation
# INPUT exact two hundred twenty byte callback from the authentic BF producer
# OUTPUT same callback with normal load replacing the first exclusive load
# TAPE zero counter one byte printer two literal scratch
# REQUIREMENT input identity exact counts and physical closure checked externally
# LIMITATION test only never an Android production callback or package input

# Copy twenty eight bytes before the acquisition load
>++[<++++++++++++++>-]<
[>,.<-]

# Consume four original bytes and emit normal load of guard into register nine
>,,,,[-]
>++++++[<++++++++++++++++>-]<+++++++++.[-]
++.[-]
>++++[<++++++++++++++++>-]<.[-]
>+++++++++++[<++++++++++++++++>-]<+++++++++.[-]

# Copy the remaining one hundred eighty eight bytes unchanged
<>+++++++++++[<++++++++++++++++>-]<++++++++++++
[>,.<-]
