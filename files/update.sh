#!/bin/bash
# ReCoded By EmossDev

tool_update_coder() {
    printf "\e[1;32m"
    echo -e "\t\t\t┌─────────────────────────"
    echo -e "\t\t\t│                         │"
    echo -e "\t\t\t│  ＵＰＤＡＴＥ  │"
    echo -e "\t\t\t│                         │"
    echo -e "\t\t\t│   \e[97mDATE : \e[33m$(date +%d.%m.%G)    \e[32m│"
    echo -e "\t\t\t│                         │"
    echo -e "\t\t\t└─────────────────────────┘"
    echo -e "\n\n\n\e[0;97m"
}

# CODER UPDATE #
if [[ $1 == update ]]; then
    if [[ ! -a updates_infos ]]; then
        exit
    fi
    if [[ -a $PREFIX/bin/bul ]]; then
        bul --swnop
    fi
    cd ..
    if [[ $2 != --full ]]; then
        date +%d.%m.%G > files/updates_infos
        clear
        echo
        echo
        echo
        echo
        tool_update_coder
        exit
    fi
    date +%d.%m.%G > $HOME/updates_infos
    git status -s >> $HOME/updates_infos
    mv $HOME/updates_infos files/updates_infos
    clear
    echo
    echo
    echo
    tool_update_coder
    cat files/updates_infos
    echo
    echo
    echo
fi
