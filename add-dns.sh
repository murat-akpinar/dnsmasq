#!/bin/bash

# Kullanıcıdan IP ve DOMAIN bilgilerini argüman olarak al
for i in "$@"
do
case $i in
    --IP=*)
    IP="${i#*=}"
    shift # geçmiş argümanları kaydır
    ;;
    --DOMAIN=*)
    DOMAIN="${i#*=}"
    shift # geçmiş argümanları kaydır
    ;;
    *)
    # bilinmeyen seçenek
    ;;
esac
done

# Eğer IP veya DOMAIN boş ise, kullanıcıyı uyar ve scripti sonlandır
if [ -z "$IP" ] || [ -z "$DOMAIN" ]; then
    echo "Hem IP hem de DOMAIN argümanları gereklidir."
    echo "Kullanım: $0 --IP=<ip-adresi> --DOMAIN=<domain-adı>"
    exit 1
fi

# /etc/dnsmasq.conf dosyasına yeni bir DNS kaydı ekleyin
echo "address=/$DOMAIN/$IP" | sudo tee -a /etc/dnsmasq.conf > /dev/null

# dnsmasq servisini yeniden başlat
sudo systemctl restart dnsmasq

echo "$DOMAIN için DNS kaydı başarıyla eklendi ve dnsmasq yeniden başlatıldı."

