FROM ubuntu:16.04

# Install basic CLI tools etc.
RUN apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        build-essential \
        curl \
        git-core \
        iputils-ping \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        wget

# Install NodeJS
COPY ./setup-10.x.sh .
RUN cat setup-10.x.sh | bash -
RUN apt-get install --yes nodejs

# Install yarn
RUN npm install -g yarn

# Install tfjs-node
RUN yarn add @tensorflow/tfjs
RUN yarn add @tensorflow/tfjs-node

# Clean up commands
RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /usr/local/src/*

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN export NODE_OPTIONS=--max_old_space_size=8192

# Set working directory
WORKDIR "/root/project"
CMD ["/bin/bash"]
