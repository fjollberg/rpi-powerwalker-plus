FROM debian:bullseye-slim

WORKDIR /opt/pmasterp

# Install dependencies
RUN apt update && apt install -y apt-utils curl unzip procps

RUN ln -s /opt/pmasterp/data/pmasterpd /etc/init.d/pmasterpd 

EXPOSE 3052/tcp
EXPOSE 3052/udp
EXPOSE 53568/tcp
EXPOSE 162/udp
EXPOSE 53566/udp

# Start
CMD ["/bin/bash","/opt/pmasterp/start.sh"] 

# Download PowerMaster from powerwalker.com
RUN curl -s https://powerwalker.com/wp-content/uploads/2022/01/pmp105_linux64.zip --output pmp105_linux64.zip 

COPY response.varfile .
COPY start.sh .
