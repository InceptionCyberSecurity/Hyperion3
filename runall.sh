#!/bin/bash
# use this to run all, or a selection of the scripts in one command line
# e.g.g to run webapp.sh,server.sh, vpn.sh and cloud.sh.....

eval "sudo "/etc/init.d/{webapp,server,vpn,cloud}.sh";"

# this keeps the comman line short and efficient!
