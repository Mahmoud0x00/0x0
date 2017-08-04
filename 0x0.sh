#!/bin/bash

echo "
           ###   #     #   ###
          #   #   #   #   #   #
         #     #   # #   #     #
         #     #    #    #     #
         #     #   # #   #     #
          #   #   #   #   #   #
           ###   #     #   ###
small script coded by - @Mahmoud0x0 , have a suggestions ? DM me on twitter @Mahmoud0x0
-------------------------------------------------------------------------------------
"
echo '[*] i see you are going to test some tragets , Right ?'

read -p '[*] Yes or No : ' answer

if [[ $answer == Yes ]]; then
  echo '[*] Hell , Lets start The Game :D'

else
  echo '[*] then Bye'
  exit 0
fi

read -p '[*] Your Target ? : ' Target
if [ "`ping -c 1 $Target`" ]; then
  echo '[*] well , the site is exist , the game just began :D'
else
  echo '[*] lol , the site is down , or Your internet is down'
fi

mkdir -p ~/Desktop/Targets/$Target
cd ~/Desktop/Tools/sub > /dev/null 2>&1
echo '[*] the script right now getting the subdomains'
python sublist3r.py -d $Target -o ~/Desktop/Targets/$Target/subs.txt > /dev/null
echo '[*] Well we have got the subdomains of the Target , Time to check them one by one :D'


for sub in $(cat ~/Desktop/Targets/$Target/subs.txt); do
  cname="$(nslookup $sub)"
  echo "DNS records : $cname"

done > ~/Desktop/Targets/$Target/Resolved_Subs.txt

echo '[*] We have Resolved the whole subdomains to ipaddress and cname'
echo '[*] Now time to make an HTML file for them so you can open them eaisly in your browser'

touch ~/Desktop/Targets/$Target/subs.html

for sub in $(cat ~/Desktop/Targets/$Target/subs.txt); do

  if ping -c 1 -W 1 "$sub"; then

    echo "<title>Subs of $Target</title>" >> ~/Desktop/Targets/$Target/subs.html
    echo "<a href=\"http://$sub\" target="_blank">$sub</a> : up!<br>" >> ~/Desktop/Targets/$Target/subs.html

  else

    echo "<a href=\"http://$sub\" target="_blank">$sub</a> : down!!<br>" >> ~/Desktop/Targets/$Target/subs.html

  fi > /dev/null 2>&1

done

echo '[*] done we have created the html file'

echo '[+] Well we have finished the process , soon a lot of features coming , stay tuned!'
