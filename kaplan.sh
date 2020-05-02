#!/bin/bash
# nehir
# coded by:  hussein kaplan :)


string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32  | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
device="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'
var=$(curl -i -s -H "$header" https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid > /dev/null)
var2=$(echo $var | grep -o 'csrftoken=.*' | cut -d ';' -f1 | cut -d '=' -f2)
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"



banner() {
printf " \n"


printf " ♥• ────────────  ──────────── •♥\n"
printf "            ♥wellcome♥\n"
printf "\033[1;97m♥• ────────────  ──────────── •♥\n"
printf "\033[1;92m≫ \033[1;92m CODDED BY :\033[1;95m Hussein Kaplan\n"
printf "\033[1;92m≫ \033[1;92m FACEBOOK:\033[1;95m https://www.facebook.com/husseinkaplan17\n"
printf "\033[1;92m≫ \033[1;92m WARNING [༗]:\033[1;95m I'M NOT RESPONSIBLE FOR Your acount and how you us it\n"

printf "\n"


}



login_user() {


if [[ $user == "" ]]; then
printf "\e[1;31m[\e[0m\e[1;77m*\e[0m\e[1;31m]\e[0m\e[1;93m You need login first\e[0m\n"
read -p $'\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;93m Username: \e[0m' user
fi

if [[ -e cookie.$user ]]; then

printf "\e[1;31m[\e[0m\e[1;77m❥\e[0m\e[1;31m]\e[0m\e[1;93m informition  found for user\e[0m\e[1;77m %s\e[0m\n" $user

default_use_cookie="Y"

read -p $'\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;93m Use it?\e[0m\e[1;77m [Y/n]\e[0m ' use_cookie

use_cookie="${use_cookie:-${default_use_cookie}}"

if [[ $use_cookie == *'Y'* || $use_cookie == *'y'* ]]; then
printf "\e[1;31m[\e[0m\e[1;77m❥\e[0m\e[1;31m]\e[0m\e[1;93m Using saved account\e[0m\n"
else
rm -rf cookie.$user
login_user
fi


else

read -s -p $'\e[1;31m☛\e[0m\e[1;77m*\e[0m\e[1;31m☜\e[0m\e[1;93m Password: \e[0m' pass
printf "\n"
data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'

IFS=$'\n'

hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] trying to login as\e[0m\e[1;93m %s\e[0m\n" $user
IFS=$'\n'
var=$(curl -c cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq ); 
if [[ $var == "challenge" ]]; then printf "\e[1;93m\n[!] Challenge required\n" ; exit 1; elif [[ $var == "logged_in_user" ]]; then printf "\e[1;92m \n[+] Login Successful\n" ; elif [[ $var == "Please wait" ]]; then echo "Please wait"; fi; 

fi

}


geo_media() {

curl -L -b cookie -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/maps/user//"

}


follow() {

username_id=$(curl -L -s 'https://www.instagram.com/'$user'' > getid && grep -o  'profilePage_[0-9]*.' getid | cut -d "_" -f2 | tr -d '"')

user_id=$(curl -L -s 'https://www.instagram.com/'$user_account'' > getid && grep -o  'profilePage_[0-9]*.' getid | cut -d "_" -f2 | tr -d '"')
data='{"_uuid":"'$guid'", "_uid":"'$username_id'", "user_id":"'$user_id'", "_csrftoken":"'$var2'"}'
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
curl -L -b cookie -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/create/$user_id/" 


}




get_followers() {

printf "\e[1;77m[\e[0m\e[1;31m+\e[0m\e[1;77m] This tool used to following/unfollowing users\e[0m\n"
printf "\e[1;77m[\e[0m\e[1;31m+\e[0m\e[1;77m] It can increase your followers up to about +50 in 1 hour \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;31m+\e[0m\e[1;77m]\e[0m\e[1;93m Press Ctrl + Z to stop \e[0m\n"
sleep 5

username_id=$(curl -L -s 'https://www.instagram.com/'$user'' > getid && grep -o  'profilePage_[0-9]*.' getid | cut -d "_" -f2 | tr -d '"')

mr_doltin="5450537592"
nour="5021860777"
banat_styel="3107115967"
bakr_khald="421004975"
haifa_hassony="534649695"
iqiq="2025903209"
saifnabeell="309511113"
basma="20224401"
najwashihab="48294511"
trybyl="2273694343"
qusaihatam="291466354"
maysanber="177841264"
shimaa_qasim="1782581874"
alkhafajitv="314195530"
star="2262677345"
noorstars="1688014286"
celebrities="1720824979"
kashkoolatheer="2134476761"
mohamedalsalim="253597769"
adil="2540710248"
raedabufatean="583450031"
athab="1782327804"
aloosh="2966187377"
hoona="3232154008"
almansory="1606183110"
ghassan="1493117803"
sollaf5="1493117803"
alsharqiyatelevision="6362536337"
adhamadil="1345062357"
awosalhlfe="359881048"
alijasimm="1928048077"
albasheershow="1928048077"
husamalrassam="1531662927"
enaastaleb="5756845644"
alturky="8505217186"
fadil="323100909"
batekhat="2201245028"
hadii="6007160070"
raneen="15066705089"
marry="5659161897"
dhurgham="1099333694"
bashar="1358380328"
alooosh="3155852957"
shahadalshemari="311258768"
ahmedalbasheer="398405019"
aliadnankadhem="398775488"
alaabbas="6982560780"
ibrahim="1826684122"
aseelhameem="1540416231"
younismahmoud="305610726"
azawy="2054876108"
alobaidi="2117640664"
amerhussen="1301749248"
algarip="1612902634"


if [[ ! -e celeb_id ]]; then
printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n" $maysanber $mileycyrus $alkhafajitv $star $noorstars $celebrities $kashkoolatheer $mohamedalsalim $adil $raedabufatean $athab $aloosh $nour $mr_doltin $banat_styel $bakr_khald $haifa_hassony $iqiq $saifnabeell $basma $najwashihab $trybyl $qusaihatam $hoona $almansory $ghassan $sollaf5 $alsharqiyatelevision $adhamadil $awosalhlfe $alijasimm $albasheershow $husamalrassam $enaastaleb $alturky $fadil $batekhat $hadii $raneen $marry $dhurgham $bashar $alooosh $shahadalshemari $ahmedalbasheer $aliadnankadhem $alaabbas $ibrahim $aseelhameem $younismahmoud $azawy $alobaidi $amerhussen $algarip > celeb_id
fi

while [[ true ]]; do


for celeb in $(cat celeb_id); do

data='{"_uuid":"'$guid'", "_uid":"'$username_id'", "user_id":"'$celeb'", "_csrftoken":"'$var2'"}'
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;93m Trying to follow user %s ..." $celeb

check_follow=$(curl -s -L -b cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/create/$celeb/" | grep -o '"following": true')

if [[ $check_follow == "" ]]; then
printf "\n\e[1;93m [!] Error\n"
exit 1
else
printf "\e[1;92mGood\e[0m\n"
fi

sleep 3

done
printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m Sleeping 900 secs...\e[0m\n"
sleep 900
#unfollow
for celeb in $(cat celeb_id); do
data='{"_uuid":"'$guid'", "_uid":"'$username_id'", "user_id":"'$celeb'", "_csrftoken":"'$var2'"}'
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;93m Trying to unfollow user %s ..." $celeb
check_unfollow=$(curl -s -L -b cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/destroy/$celeb/" | grep -o '"following": false' ) 

if [[ $check_unfollow == "" ]]; then
printf "\n\e[1;93m ! Error, stoping to prevent blocking\n"
exit 1
else
printf "\e[1;92mOK\e[0m\n"
fi

sleep 3
done
printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m Sleeping 900 secs...\e[0m\n"
sleep 900


done


}


friendship() {


data='{"_uuid":"'$guid'", "_uid":"'$username_id'", "user_id":"'$user_id'", "_csrftoken":"'$var2'"}'
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
curl -L -b cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/show/$user_id/"

}





menu() {

printf "\n"
printf " \e[1;31m☛\e[0m\e[1;77m01\e[0m\e[1;31m☚\e[0m\e[1;93m get Followers\e[0m\n"
printf " \e[1;31m☛\e[0m\e[1;77m02\e[0m\e[1;31m☚\e[0m\e[1;93m Reboret a bug \e[0m\n"
printf "\n"


read -p $' \e[1;31m[\e[0m\e[1;77m♝\e[0m\e[1;31m]\e[0m\e[1;77m Choose an option: \e[0m' option

if [[ $option -eq 1 ]]; then
login_user
get_followers



elif [[ $option -eq 2 ]]; then

 printf "\033[1;90m≫ \033[1;90m contact with me  FACEBOOK:\033[1;95m https://www.facebook.com/husseinkaplan17\n"








else

printf "\e[1;93m[!] Invalid Option!\e[0m\n"
sleep 2
menu

fi
}


banner
menu
