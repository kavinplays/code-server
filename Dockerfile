# Start from the code-server Debian base image
FROM codercom/code-server:3.9.3 

USER coder

# Apply VS Code settings 
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make

# Copy files: 
# COPY deploy-container/myTool /home/coder/myTool

# -----------

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
RUN sudo $HOME/.cargo/bin install wrangler -y

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
