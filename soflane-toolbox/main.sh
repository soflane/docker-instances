#!/bin/bash
# TODO
# - send output to file 

# Set API keys if there is any

if [[ -n "${HUNTER_IO_API_KEY}" ]]; then
  mosint set hunter $HUNTER_IO_API_KEY
  sleep 0.3
fi
if [[ -n "${EMAILREP_IO_API_KEY}" ]]; then
  mosint set emailrep $EMAILREP_IO_API_KEY
  sleep 0.3
fi
if [[ -n "${INTELLIGENCE_X_API_KEY}" ]]; then
  mosint set intelx $INTELLIGENCE_X_API_KEY
  sleep 0.3
fi
if [[ -n "${PASTEBIN_DUMPS_API_KEY}" ]]; then
  mosint set psbdmp $PASTEBIN_DUMPS_API_KEY
  sleep 0.3
fi
if [[ -n "${BREACHDIRECTORY_ORG_API_KEY}" ]]; then
  mosint set breachdirectory $BREACHDIRECTORY_ORG_API_KEY
  sleep 0.3
fi
clear

# Import needed sources
# menu choices getChoice function 
source <(wget -qO- https://raw.githubusercontent.com/the0neWhoKnocks/shell-menu-select/master/get-choice.sh)

URLregex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
emailRegex="^(([-a-zA-Z0-9\!#\$%\&\'*+/=?^_\`{\|}~]+|(\"([][,:;<>\&@a-zA-Z0-9\!#\$%\&\'*+/=?^_\`{\|}~-]|(\\\\[\\ \"]))+\"))\.)*([-a-zA-Z0-9\!#\$%\&\'*+/=?^_\`{\|}~]+|(\"([][,:;<>\&@a-zA-Z0-9\!#\$%\&\'*+/=?^_\`{\|}~-]|(\\\\[\\ \"]))+\"))@\w((-|\w)*\w)*\.(\w((-|\w)*\w)*\.)*\w{2,4}$"


# Menu definitions 
mainMenuOptions=(
    "Mosint"
    "Nexfil"
    "WP Scan - WordPress scan"
    "Set API keys"
    "Exit"
)
nexfilMainMenu=(
    "Specify username"
    "Specify a file containing username list"
    "Specify multiple comma separated usernames"
    "Specify timeout [Default : 5]"
    "Back to main menu"
)


mosintMenu () {
  tries=1
  while [ $tries -le 3 ]
  do
    read -p "Enter admin email: " email
    echo
    if [[ "$email" =~ $emailRegex ]]
    then
      echo "Email address $email is valid."
      break
    else
      echo "Email address $email is invalid."
      email="invalid"
    fi
    tries=$(( $tries + 1 ))
  done
  if [ $email == 'invalid' ]
  then
    echo "Adress must be valid. Exiting..."
    exit
  else
    mosint $email
  fi
}

wpscanmenu (){
  tries=1
  while [ $tries -le 3 ]
  do
    read -p "Enter admin URL: " url
    echo
    if [[ "$url" =~ $URLregex ]]
    then
      echo "URL $url is valid."
      break
    else
      echo "URL $url is invalid."
      url="invalid"
    fi
    tries=$(( $tries + 1 ))
  done
  if [ $url == 'invalid' ]
  then
    echo "URL must be valid. Exiting..."
    exit
  else
    wpscan --url $url --ignore-main-redirect --enumerate u 
    # docker run -it --rm wpscanteam/wpscan --url https://sundeck.be --ignore-main-redirect --enumerate u --api-token 
  fi
}


while $true
do
  getChoice -q "What do want to do ?" -o mainMenuOptions -i 3 -v "mainMenuChoice"
  case $mainMenuChoice in
      "Mosint" )
          mosintMenu
          ;;
      "Nexfil" )
          getChoice -q "Nexfil usage menu" -o nexfilMainMenu -i 3 -v "nexfilMainMenuChoice" 
          case $nexfilMainMenuChoice in
              "Specify username"  ) 
                  read -p "Enter username to search : " username
                  cd /tools/nexfil/
                  python3 nexfil.py -u $username
                  read -n 1 -r -s -p $'Press enter to continue...\n' ; clear
                  ;;
              "Specify a file containing username list" ) 
                  echo "WORK IN PROGRESS"
                  ;;
              "Specify multiple comma separated usernames"  ) 
                  read -p "Enter usernames to search separated by a \",\": "
                  nexfil.py -l 
                  read -n 1 -r -s -p $'Press enter to continue...\n' ; clear
                  ;;
              "Specify timeout [Default : 5]"  ) 
                  echo "WORK IN PROGRESS"
                  ;;
              "Back to main menu"  ) 
                  
                  ;;
          esac
          ;;
      "WP Scan - WordPress scan" )
          wpscanmenu
          read -n 1 -r -s -p $'Press enter to continue...\n' ; clear
          ;;
      "Set API keys" )
          echo "API" 
          ;;
      "Exit" )
          echo "End of program"
          exit 
          ;;
  esac

done
















































































# function print_menu()  # selected_item, ...menu_items
# {
# 	local function_arguments=($@)

# 	local selected_item="$1"
# 	local menu_items=("${function_arguments[@]:1}")
# 	local menu_size="${#menu_items[@]}"

# 	for (( i = 0; i < $menu_size; ++i ))
# 	do
# 		if [ "$i" = "$selected_item" ]
# 		then
# 			echo "-> ${menu_items[i]}"
# 		else
# 			echo "   ${menu_items[i]}"
# 		fi
# 	done
# }

# function run_menu()  # selected_item, ...menu_items
# {
# 	local function_arguments=($@)

# 	local selected_item="$1"
# 	local menu_items=("${function_arguments[@]:1}")
# 	local menu_size="${#menu_items[@]}"
# 	local menu_limit=$((menu_size - 1))

# 	clear
# 	print_menu "$selected_item" "${menu_items[@]}"
	
# 	while read -rsn1 input
# 	do
# 		case "$input"
# 		in
# 			$'\x1B')  # ESC ASCII code (https://dirask.com/posts/ASCII-Table-pJ3Y0j)
# 				read -rsn1 -t 0.1 input
# 				if [ "$input" = "[" ]  # occurs before arrow code
# 				then
# 					read -rsn1 -t 0.1 input
# 					case "$input"
# 					in
# 						A)  # Up Arrow
# 							if [ "$selected_item" -ge 1 ]
# 							then
# 								selected_item=$((selected_item - 1))
# 								clear
# 								print_menu "$selected_item" "${menu_items[@]}"
# 							fi
# 							;;
# 						B)  # Down Arrow
# 							if [ "$selected_item" -lt "$menu_limit" ]
# 							then
# 								selected_item=$((selected_item + 1))
# 								clear
# 								print_menu "$selected_item" "${menu_items[@]}"
# 							fi
# 							;;
# 					esac
# 				fi
# 				read -rsn5 -t 0.1  # flushing stdin
# 				;;
# 			"")  # Enter key
# 				return "$selected_item"
# 				;;
# 		esac
# 	done
# }


# # Usage example:

# selected_item=0
# menu_items=("Mosint" "Nexfil" "Set API keys" "Exit")

# run_menu "$selected_item" "${menu_items[@]}"
# menu_result="$?"

# echo

# case "$menu_result"
# in
# 	0)
# 		echo 'Login item selected'
# 		;;
# 	1)
# 		echo 'Register item selected'
# 		;;
# 	2)
# 		echo 'Guest item selected'
# 		;;
# 	3)
# 		echo 'Exit item selected'
# 		;;
# esac