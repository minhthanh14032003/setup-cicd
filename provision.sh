# Update package list and install necessary packages
    sudo apt-get update

    # Install Docker
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

    # Install Nginx
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    sudo bash -c 'cat > /etc/nginx/sites-available/default <<EOF
    server {
        listen 80;

        server_name 192.168.56.101;

        location / {
            proxy_pass http://localhost:5173;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }'

    sudo systemctl restart nginx

    # Install Jenkins
    # Add the Jenkins Debian repository
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update package list again
    sudo apt-get update

    # Install Jenkins
    sudo apt-get install -y fontconfig openjdk-17-jre
    sudo apt-get install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    sudo docker pull minhthanh14032003/vite-docker:v1.0
    sudo docker run -d -p 5173:8080 minhthanh14032003/vite-docker:v1.0

    # Print completion message
    echo "Docker, Nginx, and Jenkins have been installed and started."