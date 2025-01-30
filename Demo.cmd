# VersionGuard -- commands to cut and paste to run the demo.
#
# DO NOT SOURCE THIS FILE AS IT STANDS, as the user must edit a few
# files by hand at certain points in the demo.
#
# For details and legal information please see the accompanying
# VersionGuard document and LICENSE file.



# Version 1.0.1: Baseline
# Get familiar with what the executable does and how to run it.

make pristine
rm -rf vgdemo.1*
ls
make
vgdemo.1.0.1/bin/hello_static
vgdemo.1.0.1/bin/hello_dynamic
( setenv LD_LIBRARY_PATH vgdemo.1.0.1/lib ; vgdemo.1.0.1/bin/hello_dynamic )




# Version 1.0.2: Incompatible API Change
# Change the executable and library in a way that is incompatible with
# version 1.0.1.  We run it one time using the right library, to show
# the edit works, but then try running it three different ways with the
# wrong library, to show that 1) this is possible and 2) crashes.

# MAKE THE FOLLOWING EDITS:
# hellolib.cpp: change if ( bFlag ) to if ( !bFlag )
# main.cpp: change false to true
# Makefile: change VERSION to 1.0.2

make
( setenv LD_LIBRARY_PATH vgdemo.1.0.2/lib ; vgdemo.1.0.2/bin/hello_dynamic )
( setenv LD_LIBRARY_PATH vgdemo.1.0.2/lib ; vgdemo.1.0.1/bin/hello_dynamic )
( setenv LD_LIBRARY_PATH vgdemo.1.0.1/lib ; vgdemo.1.0.2/bin/hello_dynamic )
g++ -Wall -Wextra -g -fPIC -I. -o vgdemo.1.0.2/bin/hello_static main.cpp vgdemo.1.0.1/lib/libhellolib.a
vgdemo.1.0.2/bin/hello_static





# Version 1.0.3: Add VersionGuard
# We now add the VersionGuard, and again assure ourselves the new binary works.

# MAKE THE FOLLOWING EDITS:
# hellolib.h: uncomment the line with HelloLib::VersionGuard
# Makefile: change VERSION to 1.0.3

make
vgdemo.1.0.3/bin/hello_static
( setenv LD_LIBRARY_PATH vgdemo.1.0.3/lib ; vgdemo.1.0.3/bin/hello_dynamic )
nm -C vgdemo.1.0.3/bin/hello_dynamic | grep vgdemo
nm -C vgdemo.1.0.3/lib/libhellolib.so | grep vgdemo





# Version 1.0.4: Update Version With VersionGuard
# Finally, we increase the version number, and see that linking is now impossible.

# MAKE THE FOLLOWING EDITS:
# Makefile: change VERSION to 1.0.4

make
vgdemo.1.0.4/bin/hello_static
( setenv LD_LIBRARY_PATH vgdemo.1.0.4/lib ; vgdemo.1.0.4/bin/hello_dynamic )
( setenv LD_LIBRARY_PATH vgdemo.1.0.4/lib ; vgdemo.1.0.3/bin/hello_dynamic )
( setenv LD_LIBRARY_PATH vgdemo.1.0.3/lib ; vgdemo.1.0.4/bin/hello_dynamic )
g++ -Wall -Wextra -g -fPIC -I. -o vgdemo.1.0.4/bin/hello_static main.cpp vgdemo.1.0.3/lib/libhellolib.a
