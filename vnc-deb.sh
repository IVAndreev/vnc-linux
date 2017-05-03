#############################################
#  Скрипт -  Установка, настройка VNC сервера
#
#  Название скрипта -- vnc-deb.sh
#  Для DEB дистрибьютивов
#  Версия 1.0
#  Система инициализации -- systemd
#############################################

# 1. Установка x11vnc сервер
sudo apt-get install x11vnc -y

# 2. Создание пароля для подключения к серверу
sudo x11vnc -storepasswd /etc/x11vnc.pass

# 3. Создание службы запуска

cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc at startup.
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# 4. Канфигурация службы в автозапуск, перезагрузка системы.

echo "Конфигураци службы запуска выполнена корректно"
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

sleep  7s
sudo shutdown -r now
