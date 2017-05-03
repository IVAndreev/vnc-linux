#############################################
#  Скрипт -  Установка, настройка VNC сервера на KDE 5 Plasma
# 	
#  Название скрипта -- vnc-plasma-deb.sh
#  Для DEB дистрибьютивов
#  Версия 1.1
#  Система инициализации -- systemd
#############################################
echo "Внимание Скрипт не тестировался!!!!Выполнение на свой страх и риск!!!!"

# Пункт 1 - Установка X11VNC
# #################################################################
sudo apt-get install x11vnc -y

# Пункт 2 - Создание пароля, для подключения к серверу VNC.
# #################################################################

sudo x11vnc -storepasswd /etc/x11vnc.pass


# Пункт 3 - Создание службы
# #################################################################

cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc server at startup
After=graphical.target

[Service]
Type=simple
ExecStart=/bin/bash -c "/usr/bin/x11vnc -auth $(ls /var/run/sddm/{*}) -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared "

[Install]
WantedBy=graphical.target
EOF

# Пункт 4 - Конфигурация Службы
# ################################################################

echo "Конфигураци службы запуска выполнена корректно"

sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

sleep  7s
sudo shutdown -r now
