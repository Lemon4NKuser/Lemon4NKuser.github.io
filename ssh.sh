#!/bin/bash
# Скрипт для включения PasswordAuthentication в sshd_config

SSHD_CONFIG="/etc/ssh/sshd_config"

# Создаём резервную копию
cp $SSHD_CONFIG ${SSHD_CONFIG}.bak.$(date +%F_%T)

# Включаем PasswordAuthentication и PermitRootLogin
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' $SSHD_CONFIG
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' $SSHD_CONFIG

# Если строк не было — добавим
grep -q "^PasswordAuthentication yes" $SSHD_CONFIG || echo "PasswordAuthentication yes" >> $SSHD_CONFIG
grep -q "^PermitRootLogin yes" $SSHD_CONFIG || echo "PermitRootLogin yes" >> $SSHD_CONFIG

# Перезапускаем sshd
systemctl restart sshd || service ssh restart
