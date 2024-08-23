#!/bin/bash

# Sistem güncellemesi ve yükseltmesi
echo "Sistem güncelleniyor ve yükseltiliyor..."
sudo apt update

# dnsmasq kurulumu
echo "dnsmasq kuruluyor..."
sudo apt install dnsmasq -y

# UFW üzerinden 53 portunu açma
echo "53 portu UFW üzerinden açılıyor..."
sudo ufw allow 53/tcp
sudo ufw allow 53/udp

# systemd-resolved servisini durdur ve devre dışı bırak
echo "systemd-resolved servisi durduruluyor ve devre dışı bırakılıyor..."
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

# /etc/resolv.conf dosyasını kaldır ve sembolik link oluştur
echo "/etc/resolv.conf dosyası yeniden yapılandırılıyor..."
sudo rm /etc/resolv.conf
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# dnsmasq servisini yeniden başlat
sudo systemctl restart dnsmasq
sudo systemctl start dnsmasq
sudo systemctl enable --now dnsmasq
sudo systemctl status dnsmasq

# Kullanıcıya son adımlar hakkında bilgi verme
echo "Kurulum tamamlandı."
echo "Lütfen /etc/dnsmasq.conf dosyasını düzenleyerek istediğiniz DNS ayarlarını yapın ve ardından 'sudo systemctl restart dnsmasq' komutu ile dnsmasq servisini yeniden başlatın."

