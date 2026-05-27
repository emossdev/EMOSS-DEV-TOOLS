#!/bin/bash
# ReCoded By EmossDev
# Tam Çözülmüş ve De-obfuscate Edilmiş Sürüm

# GÖRSEL GÜNCELLEME EKRANI FONKSİYONU
tool_update_coder() {
    printf "\e[1;32m\n"
    printf "\t\t\t┌────────────────────────┐\n"
    printf "\t\t\t│                        │\n"
    printf "\t\t\t│      ＵＰＤＡＴＥ      │\n"
    printf "\t\t\t│                        │\n"
    printf "\t\t\t│   \e[97mＴＡＲİＨ : \e[33m$(date +%d.%m.%G)    \e[32m│\n"
    printf "\t\t\t│                        │\n"
    printf "\t\t\t└────────────────────────┘\n"
    printf "\n\n\n\e[0;97m"
}

# GÜNCELLEME TETİKLEME KONTROLÜ
if [[ $1 == "update" ]]; then
    # Güncelleme dosyası yoksa işlem yapmadan çık
    if [[ ! -a updates_infos ]]; then
        exit
    fi
    
    # Sistemde 'bul' adında bir binary/komut varsa çalıştır
    if [[ -a $PREFIX/bin/bul ]]; then
        bul --swnop
    fi
    
    cd ..
    
    # 1. KISMİ GÜNCELLEME MODU (--full parametresi yoksa)
    if [[ $2 != "--full" ]]; then
        date +%d.%m.%G > files/updates_infos
        clear
        echo; echo; echo; echo
        tool_update_coder
        exit
    fi
    
    # 2. TAM GÜNCELLEME MODU (--full parametresi varsa)
    date +%d.%m.%G > $HOME/updates_infos
    git status -s >> $HOME/updates_infos
    mv $HOME/updates_infos files/updates_infos
    clear
    echo; echo; echo; echo
    tool_update_coder
    exit
fi
