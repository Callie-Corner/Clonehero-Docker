FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get install -y curl wget unzip libicu72

WORKDIR /app
RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1w-0+deb11u2_amd64.deb
RUN dpkg -i libssl1.1_1.1.1w-0+deb11u2_amd64.deb
RUN wget https://github.com/clonehero-game/releases/releases/download/V1.0.0.4080/CloneHero-standalone_server.zip
RUN unzip CloneHero-standalone_server.zip
RUN mv /app/ChStandaloneServer-v1.0.0.4080-final/linux-x64/Server /app/
RUN chmod +x Server
RUN echo -e '#!/bin/bash\n\nprintf "$NAME\\n$PASSWORD\\n$IP\\n$PORT" | /app/Server' > /app/startserver.sh
RUN chmod +x startserver.sh



ENV NAME='clone-hero-server'
ENV PASSWORD=''
ENV IP=''
ENV PORT=''

EXPOSE 14242/udp

CMD ["bash", "/app/startserver.sh"]
