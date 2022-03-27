#!/usr/bin/env zsh

l="$(tput setaf 245)" # left
h="$(tput setaf 10)"  # highlight
n="$(tput setaf 28)"  # normal

ip=$(hostname -I 2>/dev/null | awk '{print $1}')
[ -z $ip ] && ip="$(curl -4s ifconfig.me)"
#sessions=$(who | awk '{print $5}' | wc -l)" session"
sessions=$(echo $(who | awk '{print $5}' | wc -l))" session"
[ $sessions != "1 session" ] && sessions+=s
uptime=$(($(cat /proc/uptime | cut -d'.' -f1)/86400))" day"
[ $uptime != "1 day" ] && uptime+=s
load=$(awk '{print $1, $2, $3}' /proc/loadavg)
#ram_free=$(free -m | grep "m:" | awk '{print $7}')
ram_free=$(free -m | grep "m:" | awk '{print $4}')
swp_used=$(free -m | grep "p:" | awk '{print $3}')
space1=$(df -h /    | grep dev | awk '{print $4}')
#space2=$(df -h /srv | grep dev | awk '{print $4}')

echo
echo "       ${l}Host: ${h}$(hostname) @ $ip ${n}(${h}$sessions ${n}open)"
echo "       ${l}Load: ${h}$load${n}, ${h}$uptime ${n}up"
echo "     ${l}Memory: ${h}${ram_free}M ${n}free, ${h}${swp_used}M ${n}swapped"
echo "      ${l}Space: ${h}/ ${h}$space1 ${n}free"
#echo "      ${l}Space: ${h}/ ${h}$space1 ${n}free, ${h}/srv $space2 ${n}free"


if command -v vnstat &> /dev/null; then
traffic_day=$(vnstat --oneline |  awk -F';' '{print $6}')
traffic_month=$(vnstat --oneline |  awk -F';' '{print $11}')
echo "    ${l}Traffic: ${h}$traffic_day ${n}today, ${h}$traffic_month ${n}this month"
fi

#echo

#warn=" $(tput blink; tput setaf 196)!$(tput sgr0)"
#fortune -os | cowsay -f `find /usr/share/cowsay/cows -type f -size -400c | shuf -n 1` | lolcat -f -S 50 -p 10 | sed 's/^/  /'
#fortune -asn 300 | cowsay -nf small | lolcat -f -S 50 -p 10 | sed 's/^/  /'

echo "$(tput setaf 245)"
#fortune -asn 300 | cowsay -nf small | sed 's/^/  /'
fortune -as | cowsay -nf small | sed 's/^/  /'
echo "$(tput sgr0)"
