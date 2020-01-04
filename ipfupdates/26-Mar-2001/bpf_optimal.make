
# File: Makefile
# Purpose: compile and link bpf.c.
# 
 
CC=gcc

FOR=g77
 
TOP=/usr/lib/DXM

TOPDIR=$(IPFROOTDIR)
LIBDIR=$(CYGNUSROOTDIR)

CINCLUDES =     -I.\
                -I.. \
                -I$(TOP)/lib \
                -I$(TOP)/lib/Xt

CFLAGS =        -O4 $(CINCLUDES) -DDUNDERSCORE

FFLAGS =        -O4 -DDUNDERSCORE

LINTFLAGS=      $(CINCLUDES)

LDFLAGS =       -O4 -L../ipf -L$(LIBDIR)
 
# LIBS = -lipf \
#	/usr/lib/gcc-lib/i386-redhat-linux/egcs-2.90.27/libf2c.a \
#	/usr/lib/libm.a
LIBS = -lipf_optimal -lg2c -lm

#
# the IMAGE variable is used to create the executable name
 
IMAGE = bpf_optimal.exe

#
# OBJS is a customized list of modules that are being worked on
# and are present in the current directory
  
OBJS = main.o \
	bpf_main.o \
	ipack_2.o \
	ipack_4.o \
	is_it_vms.o \
	ge_utils.o \
	c_err_exit.o

#
# This is the dependancy relationship for powerflow which
# specifies the link and causes the use of the utility compile 
# procedures below.
# WARNING: 
# The <tab> as the first character signifies the action to
# take for a given dependancy.
# The back slash causes a continuation of the current line 
# even if the line is commented out. 

$(IMAGE) : $(OBJS)
	$(FOR) -o $(IMAGE) $(OBJS) $(LDFLAGS) $(LIBS)
	size $(IMAGE)

#
#
# The following are the compile procedures for any source code specified
# in the dependancy.  These override the system defaults.
# the first procedure is for any fortran code (appendix .f creating .o)
# the second is for an C code (appendix .c creating .o)

.f.o:
	$(FOR) -c $(FFLAGS) $< 

.c.o:
	$(CC) -c $(CFLAGS) $< 

# DO NOT DELETE THIS LINE -- make depend depends on it.GS) $<