FROM debian/bullseye-slim

# Install dependencies
RUN apt update && apt upgrade -y && apt install -y wget unzip procps

# Download and install
RUN wget https://powerwalker.com/wp-content/uploads/2022/01/pmp105_linux64.zip && \
    unzip pmp105_linux64.zip && \
    chmod +x pmasterp105-linux-x86_x64.sh && \
    echo 'sys.component.588$Boolean=true\nsys.component.589$Boolean=false\nsys.languageId=en' > response.varfile && \
    ./pmasterp105-linux-x86_x64.sh -q -varfile response.varfile && \
    rm -f pmp105_linux64.zip response.varfile pmasterp105-linux-x86_x64.sh

# Create the start script
RUN echo 'service pmasterpd start & trap : TERM INT; sleep infinity & wait' > start.sh && \
    chmod +x start.sh

# Start
CMD ./start.sh
