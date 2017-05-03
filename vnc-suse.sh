#############################################
#  Скрипт -  Установка, настройка VNC сервера для OpenSUSE 42.2
#
#  Название скрипта -- vnc-suse.sh
#  Для SUSE дистрибьютивов
#  Версия 1.0
#  Система инициализации -- systemd
#############################################

# Пункт 1 - Установка xorg-x11

sudo zypper install xorg-x11

# Пункт 2 - Установка X11VNC
sudo zypper install x11vnc

# Пункт 3 - Создание пароля, для подключения к серверу VNC.

sudo x11vnc -storepasswd /etc/x11vnc.pass

# Пункт 4 - Создание службы

cat > /etc/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc at startup.
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# Пункт 4  Завершение установки и настройки VNC в OpenSUSE 42.2 (Создание Автозапуска)


echo "Конфигураци службы запуска выполнена корректно"
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

sleep  7s
sudo shutdown -r now
