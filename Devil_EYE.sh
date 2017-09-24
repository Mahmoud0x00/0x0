#!/bin/bash

echo "


           ____             _ _   _______   _______
          |  _ \  _____   _(_) | | ____\ \ / / ____|
          | | | |/ _ \ \ / / | | |  _|  \ V /|  _|
          | |_| |  __/\ V /| | | | |___  | | | |___
          |____/ \___| \_/ |_|_| |_____| |_| |_____|
                      Coded by @Mahmoud0x00
"
echo '[*] i see you are going to test some Targets , Right ?'

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
  echo '[*] check the domain which you have put in Target'
  exit 0
fi


if [ -d ~/Desktop/Targets/$Target ]; then

  read -p '[*] Wait , this Target already tested , Would You like to test it again ? , Yes or No : ' reply

  if [[ $reply == Yes  ]]; then
    echo '[*] Well Thats your choice :D'
    rm -rf ~/Desktop/Targets/$Target/
  else
    echo '[*] Damn!! , Nice choice :D , You have just saved Your Trash :D'
    exit 0
  fi

fi


mkdir -p ~/Desktop/Targets/$Target

if [ -d ~/Desktop/Tools/Sublist3r ]; then
  echo '[*] sublist3r is exist'

else
  echo '[*] Please Download sublist3r and host it in ~/Desktop/Tools/Sublist3r-master'
fi
cd ~/Desktop/Tools/Sublist3r > /dev/null 2>&1
echo '[*] the script right now getting the subdomains'
python sublist3r.py -d $Target -o ~/Desktop/Targets/$Target/subs.txt > /dev/null 2>&1
echo '[*] Well we have got the subdomains of the Target , Time to check them one by one :D'
echo '[*] Now time to make an HTML file for them so you can open them eaisly in your browser'

touch ~/Desktop/Targets/$Target/subs.html

for sub in $(cat ~/Desktop/Targets/$Target/subs.txt); do
  ip="$(dig +short $sub)"
  if [ "`ping -c 1 $sub`" ]; then

    echo "<title>Subs of $Target</title>" >> ~/Desktop/Targets/$Target/subs.html
    echo "<a href=\"http://$sub\" target="_blank">$sub</a> : up!<br>info : $ip <br>" >> ~/Desktop/Targets/$Target/subs.html

  else

    echo "<a href=\"http://$sub\" target="_blank">$sub</a> : down!!<br>" >> ~/Desktop/Targets/$Target/subs.html

  fi > /dev/null 2>&1

done

echo '[*] done we have created the html file'

echo '[*] Time to Create File for Up Hosts and Down Hosts'
touch ~/Desktop/Targets/$Target/up_hosts.txt
touch ~/Desktop/Targets/$Target/down_hosts.txt
for HOST in $(cat ~/Desktop/Targets/$Target/subs.txt); do
  if [ "`ping -c 1 $HOST`" ]; then
    echo $HOST >> ~/Desktop/Targets/$Target/up_hosts.txt
  else
    echo $HOST >> ~/Desktop/Targets/$Target/down_hosts.txt
  fi
done > /dev/null 2>&1
echo '[+] Well we have finished the process , soon a lot of features coming , stay tuned!'
