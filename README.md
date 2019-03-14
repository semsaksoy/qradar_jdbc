Qradar JDBC Workaround

Auto disable-enable jdbc log sources on Qradar SIEM after connection problem by using API


#disable-enable jdbc log sources that do not get event for longer than threshold


## DB log sources restart
#cron installation
20 * * * * /bin/ruby /root/AutoDE/main.rb >/dev/null 2>&1

Qradar api log source supports after version 7.3.1
