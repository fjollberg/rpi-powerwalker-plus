FROM debian:bullseye-slim

WORKDIR /opt/pmasterp

# Install dependencies
RUN apt update && apt install -y apt-utils curl unzip procps

EXPOSE 3052/tcp
EXPOSE 3052/udp
EXPOSE 53568/tcp
EXPOSE 162/udp
EXPOSE 53566/udp

# Download PowerMaster from powerwalker.com
RUN curl -s https://powerwalker.com/wp-content/uploads/2022/01/pmp105_linux64.zip --output pmp105_linux64.zip 

COPY pmasterpd.service /etc/systemd/system/
COPY response.varfile .
COPY start.sh .

# Start
CMD /opt/pmasterp/start.sh
