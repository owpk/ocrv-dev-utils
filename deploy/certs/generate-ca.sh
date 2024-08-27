#!/bin/bash

# Шаг 1. Создание собственного самоподписанного доверенного сертификата.
# 
# Собственный доверенный сертификат (Certificate Authority или CA) необходим для подписи клиентских сертификатов и для их проверки при авторизации клиента веб-сервером.
# С помощью приведенной ниже команды создается закрытый ключ и самоподписанный сертификат.

openssl req -new -newkey rsa:1024 -nodes -keyout ca.key -x509 \
   -days 500 -subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com \
   -out ca.crt

# Описание аргументов:
# 
# req Запрос на создание нового сертификата.
# -new Создание запроса на сертификат (Certificate Signing Request – далее CSR).
# -newkey rsa:1023 Автоматически будет создан новый закрытый RSA ключ длиной 1024 бита. Длину ключа можете настроить по своему усмотрению.
# -nodes Не шифровать закрытый ключ.
# -keyout ca.key Закрытый ключ сохранить в файл ca.key.
# -x509 Вместо создания CSR (см. опцию -new) создать самоподписанный сертификат.
# -days 500 Срок действия сертификата 500 дней. Размер периода действия можете настроить по своему усмотрению. Не рекомендуется вводить маленькие значения, так как этим сертификатом вы будете подписывать клиентские сертификаты.
# -subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com
# Данные сертификата, пары параметр=значение, перечисляются через ‘/’. Символы в значении параметра могут быть «подсечены» с помощью обратного слэша «\», например «O=My\ Inc». Также можно взять значение аргумента в кавычки, например, -subj «/xx/xx/xx».
# 
# Шаг 2. Сертификат сервера
# 
# Создадим сертификат для nginx и запрос для него
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr

# Подпишем сертификат нашей же собственной подписью
openssl x509 -req -days 365 -in server.csr -CA ca.crt \
   -CAkey ca.key -set_serial 01 -out server.crt

# Чтобы nginx при перезагрузке не спрашивал пароль, сделаем для него беспарольную копию сертификата
openssl rsa -in server.key -out server.nopass.key

# Конфиг nginx
# 
# listen *:443;
# ssl on;
# ssl_certificate /path/to/nginx/ssl/server.crt;
# ssl_certificate_key /path/to/nginx/ssl/server.nopass.key;
# ssl_client_certificate /path/to/nginx/ssl/ca.crt;
# ssl_verify_client on;
# 
# keepalive_timeout 70;
# fastcgi_param SSL_VERIFIED $ssl_client_verify;
# fastcgi_param SSL_CLIENT_SERIAL $ssl_client_serial;
# fastcgi_param SSL_CLIENT_CERT $ssl_client_cert;
# fastcgi_param SSL_DN $ssl_client_s_dn;
# 
# теперь сервер готов принимать запросы на https.
# в переменных к бекенду появились переменные с информацией о сертификате, в первую очередь SSL_VERIFIED (принимает значение SUCCESS).
# 
# Однако если вы попытаетесь зайти на сайт, он выдаст ошибку:
# 400 Bad Request
# No required SSL certificate was sent
# 
# Что ж, логично, в этом-то и вся соль!

# Шаг 3. Создание клиентских сертификатов

# 3.1 Подготовка CA

# Создадим конфиг со следующим содержимым:
cat << EOF >> ca.config
[ ca ]
default_ca = CA_CLIENT # При подписи сертификатов # использовать секцию CA_CLIENT

[ CA_CLIENT ]
dir = ./db # Каталог для служебных файлов
certs = \$dir/certs # Каталог для сертификатов
new_certs_dir = \$dir/newcerts # Каталог для новых сертификатов

database = \$dir/index.txt # Файл с базой данных подписанных сертификатов
serial = \$dir/serial # Файл содержащий серийный номер сертификата (в шестнадцатеричном формате)
certificate = ./ca.crt # Файл сертификата CA
private_key = ./ca.key # Файл закрытого ключа CA

default_days = 365 # Срок действия подписываемого сертификата
default_crl_days = 7 # Срок действия CRL
default_md = md5 # Алгоритм подписи

policy = policy_anything # Название секции с описанием политики в отношении данных сертификата

[ policy_anything ]
countryName = optional # Поля optional - не обязательны, supplied - обязательны
stateOrProvinceName = optional
localityName = optional
organizationName = optional
organizationalUnitName = optional
commonName = optional
emailAddress = optional
EOF
# 
# Далее надо подготовить структуру каталогов и файлов, соответствующую описанной в конфигурационном файле

mkdir db
mkdir db/certs
mkdir db/newcerts
touch db/index.txt
echo "01" > db/serial


# 3.2. Создание клиентского закрытого ключа и запроса на сертификат (CSR)
# 
# Для создания подписанного клиентского сертификата предварительно необходимо создать запрос на сертификат, для его последующей подписи. 
# Аргументы команды полностью аналогичны аргументам использовавшимся при создании самоподписанного доверенного сертификата, но отсутствует параметр -x509.

openssl req -new -newkey rsa:1024 \
   -nodes -keyout client01.key \
   -subj /C=RU/ST=Moscow/L=Moscow/O=Companyname/OU=User/CN=etc/emailAddress=support@site.com \
   -out client01.csr

# В результате выполнения команды появятся два файла client01.key и client01.csr.
# 
# 3.3. Подпись запроса на сертификат (CSR) с помощью доверенного сертификата (CA).
# При подписи запроса используются параметры заданные в файле ca.config

openssl ca -config ca.config -in client01.csr -out client01.crt -batch


# В результате выполнения команды появится файл клиентского сертификата client01.crt.
#
# Для создания следующих сертификатов нужно повторять эти два шага.
# 
# 3.4. Создание сертификата в формате PKCS#12 для браузера клиента
# 
# Это на тот случай, если к вашему серверу подключаются не бездушные машины, как в моём случае, а живые люди через браузер.
# Запароленный файл PKCS#12 надо скормить браузеру, чтобы он смог посещать ваш сайт.

openssl pkcs12 -export -in client01.crt -inkey client01.key \
   -certfile ca.crt -out client01.p12 \
   -passout pass:1422

# 3.5 Подключение к полученному ssl cерверу с помощью curl

# curl -k --key client.key --cert client1.crt --url "https://site.com"
# Использована опция -k, потому что сертификат в примере самоподписанный
