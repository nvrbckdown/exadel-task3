#!/bin/bash
HELLO_PAGE=/var/www/html/hello.html
OS_INFO=$(cat /etc/os-release)
MEMORY_INFO=$(free -h)
DISK_INFO=$(df -H)
PROCESS_INFO=$(ps aux)


function install_nginx() {
        sudo apt install nginx -y
        sudo chown -R $USER:$USER /var/www/html/
}

function create_hello_page() {
        cat > $HELLO_PAGE << EOF
        <!DOCTYPE html>
        <html>
          <head>
             <title>Hello World Page</title>
          </head>
          <body>
          <pre>
          <h1> HELLO WORLD </h1>
          <h1> OS info </h1>
          <pre>$OS_INFO</pre>
          <h1> Memory info </h1>
          <pre>$MEMORY_INFO</pre>
          <h1> Disk info </h1>
          <pre>$DISK_INFO</pre>
          <h1> Process info </h1>
          <pre>$PROCESS_INFO</pre>
          </body>
        </html>
EOF
}

function install_docker() {
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
        sudo apt update
        apt-cache policy docker-ce
        sudo apt install docker-ce -y
        sudo usermod -aG docker ubuntu
}

install_nginx
create_hello_page
install_docker