#!/bin/bash

echo -e "\033[2J\033[3;1f"

eval "cat ~/Nexa/assets/download.txt"
printf "\n\n\033[1;35mNexa устанавливается... ✨\033[0m"

echo -e "\n\n\033[0;96mУстановка базовых пакетов...\033[0m"

eval "pkg i git python libjpeg-turbo openssl -y"

printf "\r\033[K\033[0;32mПакеты готовы!\e[0m\n"
echo -e "\033[0;96mУстановка библиотеки Pillow...\033[0m"

if eval "lscpu | grep Architecture" | grep -qE 'aarch64'; then
    eval 'export LDFLAGS="-L/system/lib64/"'
else
    eval 'export LDFLAGS="-L/system/lib/"'
fi

eval 'export CFLAGS="-I/data/data/com.termux/files/usr/include/" && pip install Pillow -U --no-cache-dir'

printf "\r\033[K\033[0;32mБиблиотека Pillow установлена!\e[0m\n"
echo -e "\033[0;96mСкачивание исходного кода...\033[0m"

eval "rm -rf ~/Nexa 2>/dev/null"
eval "cd && git clone https://github.com/Filasovskiy/Nexa && cd Nexa"

echo -e "\033[0;96mИсходный код скачан!...\033[0m\n"
printf "\r\033[0;34mУстановка зависимостей...\e[0m"

eval "pip install -r requirements.txt --no-cache-dir --no-warn-script-location --disable-pip-version-check --upgrade"

printf "\r\033[K\033[0;32mЗависимости установлены!\e[0m\n"

if [[ -z "${NO_AUTOSTART}" ]]; then
    printf "\n\r\033[0;34mНастройка автозапуска...\e[0m"

    eval "echo '' > ~/../usr/etc/motd &&
    echo 'clear && . <(wget -qO- https://raw.githubusercontent.com/Filasovskiy/Nexa/refs/heads/main/banner.sh) && cd ~/Nexa && python3 -m nexa' > ~/.bash_profile"

    printf "\r\033[K\033[0;32mАвтозапуск настроен!\e[0m\n"
fi

echo -e "\033[0;96mЗапуск юзербота Nexa...\033[0m"
echo -e "\033[2J\033[3;1f"

printf "\033[1;32mNexa запускается...\033[0m\n"

eval "python3 -m nexa"