#!/usr/bin/env bash
# (C) 2017  Cercel Valentin
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#################################################################
# copy this script to /etc/snmp/ and make it executable:        #
# chmod +x /etc/snmp/exim-stats.sh                              #
# ------------------------------------------------------------- #
# edit your snmpd.conf and include:                             #
# extend exim-stats /etc/snmp/exim-stats.sh                     #
# ------------------------------------------------------------- #
# restart snmpd and activate the app for desired host           #
#################################################################
BIN_EXIM=$(which exim)
BIN_GREP=$(which grep)
BIN_WC=$(which wc)
CFG_EXIM_1='-bp'
CFG_EXIM_2='-bpc'
CFG_GREP='frozen'
CFG_WC='-l'
#################################################################

FROZEN=$($BIN_EXIM $CFG_EXIM_1 | $BIN_GREP $CFG_GREP | $BIN_WC $CFG_WC)
echo "$FROZEN"

QUEUE=$($BIN_EXIM $CFG_EXIM_2)
echo "$QUEUE"
