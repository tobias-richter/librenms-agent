#!/usr/bin/env bash

CONFIGFILE=/etc/snmp/freeradius.conf

# Set 0 for SNMP extend; set to 1 for Check_MK agent
AGENT=0

# Set FreeRADIUS status_server details
RADIUS_SERVER='localhost'
RADIUS_PORT='18121'
RADIUS_KEY='adminsecret'

if [ -f $CONFIGFILE ]; then
    # shellcheck disable=SC1090
    . $CONFIGFILE
fi

# Default radclient access request, shouldn't need to be changed
RADIUS_STATUS_CMD='Message-Authenticator = 0x00, FreeRADIUS-Statistics-Type = 31, Response-Packet-Type = Access-Accept'

# Pathes for grep and radclient executables, should work if within PATH
BIN_GREP="$(command -v grep)"
BIN_RADCLIENT="$(command -v radclient)"

if [ $AGENT == 1 ]; then
  echo "<<<freeradius>>>"
fi

RESULT=$(echo "$RADIUS_STATUS_CMD" | $BIN_RADCLIENT -x $RADIUS_SERVER:$RADIUS_PORT status $RADIUS_KEY)

echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Access-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Access-Accepts = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Access-Rejects = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Access-Challenges = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Responses = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Duplicate-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Malformed-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Invalid-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Dropped-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Auth-Unknown-Types = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Accounting-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Accounting-Responses = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Acct-Duplicate-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Acct-Malformed-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Acct-Invalid-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Acct-Dropped-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Acct-Unknown-Types = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Access-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Access-Accepts = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Access-Rejects = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Access-Challenges = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Responses = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Duplicate-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Malformed-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Invalid-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Dropped-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Auth-Unknown-Types = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Accounting-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Accounting-Responses = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Acct-Duplicate-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Acct-Malformed-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Acct-Invalid-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Acct-Dropped-Requests = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Total-Proxy-Acct-Unknown-Types = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-Len-Internal = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-Len-Proxy = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-Len-Auth = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-Len-Acct = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-Len-Detail = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-PPS-In = [[:digit:]]*'
echo "$RESULT" | $BIN_GREP -o 'FreeRADIUS-Queue-PPS-Out = [[:digit:]]*'
