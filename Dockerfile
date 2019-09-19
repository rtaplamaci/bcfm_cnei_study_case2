FROM node:latest

MAINTAINER Ramazan Taplamacı <ramazantaplamai81@gmail.com>

#Projenin kaynak dosyalarını nereye kopyalacak.
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
