#!/bin/bash
HELLO_PAGE=/var/www/html/hello.html


function install_nginx() {
    sudo yum update
    sudo yum install nginx -y
    sudo nginx
    sudo mkdir -p /var/www/html/
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
          </body>
        </html>
EOF
}

install_nginx
create_hello_page