# MODULE isolated two byte binary conversion main
# PURPOSE read two bytes and emit them in reverse order
# INPUT raw bytes with zero on EOF
# OUTPUT second byte then first byte including zero and FF
# TAPE cell zero first byte cell one second byte
# PROFILE extra input is unconsumed and no state is shared with any handler

,>,.<.

# END real binary main module
