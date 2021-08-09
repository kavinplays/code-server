FROM codercom/code-server:3.9.3 

USER coder

COPY settings.json .local/share/code-server/User/settings.json

ENV SHELL=/bin/bash

RUN sudo apt-get update && sudo apt-get install unzip -y

RUN sudo chown -R coder:coder /home/coder

RUN sudo curl -fsSL https://deb.nodesource.com/setup_14.x | sudo bash -
RUN sudo apt-get install -y nodejs
RUN sudo apt install software-properties-common -y
RUN sudo add-apt-repository ppa:deadsnakes/ppa -y
RUN sudo apt install python3 -y
RUN sudo apt-get install -y python3-pip
RUN code-server --install-extension ms-python.python
RUN git config --global user.name "Kavin Shanbhag"
RUN git config --global user.email "kavinplays@icloud.com"
RUN sudo curl -fsSL https://get.deta.dev/cli.sh | sh
RUN sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN sudo cargo install wrangler

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
