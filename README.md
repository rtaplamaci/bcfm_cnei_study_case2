## Cloud Native Engineer Intern Case Study
Tüm bu işlemler Ubuntu 18.04.3 LTS işletim sisteminde gerçekleştirilmiştir.
NodeJs Projesi Deploy Etme Görevi

* GÖREV 1: Herhangi bir dilde yazılmış örnek bir web uygulamasının Dockerfile kullanılarak docker imajı
haline getirilmesi.

Bu görev için öncelikli olarak Dosya sisteminde bir klasör oluşturdum. Ardından ilgili proje dosyalarını ilgili dizine taşıdım.

* Proje Dosyaları

index.js
```bash
var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', function (socket) {
    socket.on('chat message', function (msg) {
        io.emit('chat message', msg);
    });
});

http.listen(3000, function () {
    console.log('listening on *:3000');
});
 ```
 
 index.html
```bash
<!doctype html>
<html>

<head>
    <title>Socket.IO chat</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font: 13px Helvetica, Arial;
        }
        form {
            background: #000;
            padding: 3px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        form input {
            border: 0;
            padding: 10px;
            width: 90%;
            margin-right: .5%;
        }
        form button {
            width: 9%;
            background: rgb(130, 224, 255);
            border: none;
            padding: 10px;
        }
        #messages {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        #messages li {
            padding: 5px 10px;
        }
        #messages li:nth-child(odd) {
            background: #eee;
        }
    </style>
</head>

<body>
    <ul id="messages"></ul>
    <form action="">
        <input id="m" autocomplete="off" /><button>Send</button>
    </form>
    <script src="/socket.io/socket.io.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.1.js"></script>
    <script>
        $(function () {
            var socket = io();
            $('form').submit(function (e) {
                e.preventDefault(); // prevents page reloading
                socket.emit('chat message', $('#m').val());
                $('#m').val('');
                return false;
            });
        });
    </script>

    <script>
        $(function () {
            var socket = io();
            $('form').submit(function (e) {
                e.preventDefault(); // prevents page reloading
                socket.emit('chat message', $('#m').val());
                $('#m').val('');
                return false;
            });
            socket.on('chat message', function (msg) {
                $('#messages').append($('<li>').text(msg));
            });
        });
    </script>
</body>

</html>
 ```
 package.json
```bash

{
  "name": "socketiochat",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "rt",
  "license": "ISC",
  "dependencies": {
    "express": "^4.15.2",
    "socket.io": "^2.2.0"
  }
}
 ```
 
 Ardından terminal ekranından Nano editörü ile Dockerfile dosyasını oluşturdum ve içeriğini aşağıdaki gibi düzenledim.

```bash
#Projenin kullanacağı pakte
FROM node:latest

MAINTAINER Ramazan Taplamacı <ramazantaplamai81@gmail.com>

#Projenin kaynak dosyaları için dizin oluşturulması.
WORKDIR /usr/src/node-app

#Gerekli package.json dosyasının kopyalanması.
COPY package.json ./

#package.json daki gerekli kütüphanelerin yüklenmesi için gerekli.
#Express, socker-io, vs.
RUN npm install --only=production

#"." bütün kaynak kodları -> "." workdir de belirttiğim klasöre kopyala.
COPY . .

#kullanılacak port.
EXPOSE 3000

#docker run komutunu çalıştırırken çalışıcak komut.
ENTRYPOINT [ "node" ]

#docker run komutunu çalıştırırken ENTRYPOINT komutunun yanına eklenicek ekstra parametre
#docker run komutunu çalıştırırken değiştirebiliriz.
CMD [ "index.js" ]

```

 Ardından istemediğim dosyaların Docker İmajına kopyalanmaması için terminal üzerinde nano editörü ile .dockerignore dosyasını oluşturdum ve içeriğini aşağıdaki gibi düzenledim.
```bash
Dockerfile
node_modules
npm-debug.log
 ```

Ardından Docker image dosyasını oluşturmak için Docker CLI ile aşağıdaki komutu kullandım.

```bash
docker build -t rtaplamaci/ramazan_taplamaci_node:0.2 .
```
ve Docker imajım oluştu.

* GÖREV 2: Docker hub üzerinden bir hesap açılarak dockerize edilen imajın açılan hesaba
isim_soyisim:0.1* şeklinde psuh edilmesi.
(* Aynı isimde imaj olduğundan imaj adı rtaplamaci/ramazan_taplamaci_node:0.2 olarak değiştirildi)

Bu görevi tamalamak için öncelikli olarak Docker Hub hesabı edindim ve terminal üzerinden giriş işlmelerimi tamamladım ardından ilgili imajı Docker Hub'a push edebilmek için aşağıdaki komutu kullandım.

```bash
docker push rtaplamaci/ramazan_taplamaci_node:0.2
```
push işlemim tamamlandı. Buna istinaden [buraya tıklayarak](https://cloud.docker.com/u/rtaplamaci/repository/docker/rtaplamaci/ramazan_taplamaci_node) Docker Hub'da bulunan imaja ulaşabilirsiniz. 


* GÖREV 3: İlgili imajı docker hub üzerinden çekerek, herhangi bir ortamda çalışıtırılıp browser üzerinden
çalıştığının gösterilmesi. Local ortamlarınız kullanılabilinir veya herhangi bir cloud provide
kullanabilirsiniz.

Bu görev için ise öncelikli olarak hali hazırda bilgisayarımda bulunan imajı aşağıdaki komutu kullanarak sildim.

```bash
docker rmi rtaplamaci/ramazan_taplamaci_node:0.2
```
Ardından Docker Hub'da bulunan imajı pull etmek için aşağıdaki kod bloğunu kullandım.
```bash
docker pull rtaplamaci/ramazan_taplamaci_node:0.2
```
Bilgisayarıma inen imajı çalıştırmak için ise Docker CLI'de aşağıdaki komutu kullandım.
```bash
docker run --name ramazan_taplamaci_node -p 3000:3000  -e PORT=3000 -d rtaplamaci/ramazan_taplamaci_node:0.2
```
Ardından browserımda http://localhost:3000/ adresinden hali hazırda hazırlamış olduğum html çıktıyı görüntüledim.


