Qradar JDBC Workaround

"QRadar supports many protocols. Passive protocols listen to events on specific ports. Active protocols use APIs or other communication tools to poll events and connect to external systems."

JDBC is an active protocol that sends "SELECT" queries to any relational database. Sometimes there may be a connection issue between qradar and database servers. In which case, qradar will  retry connect and gives up after a few attempts. The log source will not work even if the connection is established. Qradar documents suggests disable-enable log source.

This script will disable and enable jdbc log sources for you which not get events in determined treshold time.


Auto disable-enable jdbc log sources on Qradar SIEM after connection problem by using API


#disable-enable jdbc log sources that do not get event for longer than threshold


## JDBC log sources restart
#cron installation
20 * * * * /bin/ruby /root/AutoDE/main.rb >/dev/null 2>&1

Qradar api log source supports after version 7.3.1


Scripts are not official IBM solutions. IBM highlights [Modified (YUM) is not supported through all other installations of non-QRadar software modules, RPMs, or Yellowdog Updater](https://www-01.ibm.com/support/docview.wss?uid=swg21991208). Use at your own risk.
