FROM debian:bullseye-slim

# Install dependencies
RUN apt update && apt install -y apt-utils curl unzip procps

# Download and install
RUN curl -s https://powerwalker.com/wp-content/uploads/2022/01/pmp105_linux64.zip --output pmp105_linux64.zip && \
    unzip pmp105_linux64.zip && \
    chmod +x pmasterp105-linux-x86_x64.sh && \
    echo 'sys.component.588$Boolean=true\nsys.component.589$Boolean=false\nsys.languageId=en' > response.varfile && \
    ./pmasterp105-linux-x86_x64.sh -q -varfile response.varfile && \
    rm -f pmp105_linux64.zip response.varfile pmasterp105-linux-x86_x64.sh

# Create the start script
RUN echo 'service pmasterpd start & trap : TERM INT; sleep infinity & wait' > start.sh && \
    chmod +x start.sh

EXPOSE 3052/tcp
EXPOSE 3052/udp
EXPOSE 53568/tcp
EXPOSE 162/udp
EXPOSE 53566/udp

# Start
CMD ./start.sh
