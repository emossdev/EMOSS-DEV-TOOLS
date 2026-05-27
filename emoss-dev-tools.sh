#!/bin/bash
clear

githubUsername="EmossDev"

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi

# CURL  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURLUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi
# jQ  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/jq ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m JQ PAKETİ KURLUYOR"
	echo
	echo
	echo
	pkg install jq -y
fi

control=$(ping -c 1 github.com |wc -l)
if [[ $control == 0 ]];then
	echo
	echo
	echo
	printf "\e[1;31m
	[!] \e[97mHATA OLUŞTU \e[31m!!!\e[33m

	[*] \e[97mİNTERNET BAĞLANTINIZI KONTROL EDİN
	"
	echo
	echo
	echo
	exit
fi
if [[ -a $PREFIX/lib/EMOSS-DEV-TOOLS ]];then
	
	control=$(cat $PREFIX/lib/EMOSS-DEV-TOOLS/.git/config |grep url |awk -F '/' '{print $4}')
	
	if [[ $control != $githubUsername ]];then
		
		rm -rf $HOME/.EMOSS-DEV-TOOLS
		
		if [[ -a $PREFIX/bin/emossdevtools ]];then
			rm $PREFIX/bin/emossdevtools
		fi
	fi	
fi
if [[ ! -a $PREFIX/bin/emossdevtools ]];then
	cd files
	cp .tools-emossdev /data/data/com.termux/files/usr/bin/emossdevtools
	cd ..
	mkdir $PREFIX/lib/EMOSS-DEV-TOOLS
	mv * $PREFIX/lib/EMOSS-DEV-TOOLS
	mv .git $PREFIX/lib/EMOSS-DEV-TOOLS
	cd $HOME
	repoName=$(cat EMOSS-DEV-TOOLS/.git/config |grep url |awk -F '/' '{print $5}')
	if [[ -a $repoName ]];then
		rm -rf $repoName
	fi
	chmod 777 /data/data/com.termux/files/usr/bin/emossdevtools
	chmod 777 $PREFIX/lib/EMOSS-DEV-TOOLS/emoss-dev-tools.sh
	echo
	echo
	echo
	echo
	printf "\e[32m
	\t╔════════════════════════╗
	\t║                        ║
	\t║   \e[97mＫＵＲＵＬＵＭ\e[32m       ║
	\t║                        ║
	\t║   \e[97mＴＡＭＡＭＬＡＮＤＩ\e[32m ║
	\t║                        ║
	\t╚════════════════════════╝
	\n\n\e[97m"
	sleep 1
	echo
	echo
	echo
	printf "\e[32m
	\t╔════════════════════════════════════╗
	\t║ \e[97mÇALIŞTIRMAK İÇİN \e[32memossdevtools \e[97mYAZ \e[32m║
	\t╚════════════════════════════════════╝\e[97m"
	echo
	echo
	echo
	exit
fi
cd files
bash update.sh
if [[ -a ../updates_infos ]];then
	rm ../updates_infos
	exit
fi
bash banner.sh
curl -s "https://api.github.com/users/$githubUsername/repos?per_page=100" | jq -r ".[].name" | xargs -L1 > tools.txt
total=$(cat tools.txt |wc -l)
color=$(cat .color.txt)
for no in `seq 1 $total` ; do
	if [[ $no -le 9 ]];then
		printf "
		          \e[97m[$no]  $color $(sed -n $no\p tools.txt)
		"
	elif [[ $no -gt 9 ]];then
		printf "
		          \e[97m[$no] $color $(sed -n $no\p tools.txt)
		"
	fi
done
echo
echo
echo
read -e -p $' \e[97m[ \e[92mEmossDevTools \e[97m]\e[92m ~ \e[91m»» \e[0m' secim
if [[ $secim == x || $secim == X || $secim == exit ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[0m ÇIKIŞ YAPILDI \e[31m!!!\e[0m"
	echo
	echo
	echo
	rm tools.txt
	exit
fi
total=$(cat tools.txt |wc -l)
if [[ $secim -gt $total ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[0m HATALI SEÇİM \e[31m!!!\e[0m"
	echo
	echo
	echo
	rm tools.txt
	exit
fi
if [[ $secim -le 0 ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[0m HATALI SEÇİM \e[31m!!!\e[0m"
	echo
	echo
	echo
	rm tools.txt
	exit
fi
echo
echo
echo
directory="$HOME"
directory_name='HOME'

if [[ -n $1 ]];then
	directory="$(cat .pwd)"
	directory_name=$(basename $directory)
fi

toolName=$(sed -n $secim\p tools.txt)
if [[ -a $directory/$toolName ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m $toolName ZATEN KAYITLI \e[31m!!!\e[97m"
	echo
	echo
	echo
	read -e -p $'TEKRAR İNDİRİLSİN Mİ ? [ \e[32mE\e[97m / \e[31mH\e[97m ] \e[31m>>\e[0m ' secenek
	echo
	echo
	echo
	if [[ $secenek == h || $secenek == H || $secenek == hayır || $secenek == HAYIR ]];then
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m TEKRAR İNDİRME İPTAL EDİLDİ \e[31m!!!\e[97m"
		echo
		echo
		echo
		exit
	
	fi
	rm -rf $directory/$toolName
fi

printf "\e[32m[✓]\e[92m $toolName \e[33m $directory_name \e[97mDİZİNİNE İNDİRİLİYOR "
echo
echo
echo
git clone https://github.com/$githubUsername/$toolName
mv $toolName $directory
rm tools.txt

