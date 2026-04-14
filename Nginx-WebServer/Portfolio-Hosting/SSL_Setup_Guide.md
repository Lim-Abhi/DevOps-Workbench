## Overview

This document explains how to secure an Nginx web server using HTTPS (SSL/TLS) with Let’s Encrypt Certbot on an AWS EC2 Ubuntu instance.


## Prerequisites

Before starting, ensure:

- EC2 instance is running (Ubuntu)
- Nginx is installed and working
- Domain is pointing to EC2 public IP (DNS configured)
- Port 80 and 443 are open in Security Group



Step 1: Install Certbot
```
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

Step 2: Verify Nginx is Working
```
sudo systemctl status nginx
```

Step 3: Generate SSL Certificate
```
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

Step 4: SSL Certificate Location
```
/etc/letsencrypt/live/yourdomain.com/
```
Files:
- fullchain.pem → SSL certificate (public chain)
- privkey.pem → private key

Step 5: Manual Nginx SSL Config
```
server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;

    root /var/www/html/portfolio-web;
    index index.html;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Step 6: Validate and Restart Nginx
```
sudo nginx -t
sudo systemctl restart nginx
```


Important Note:
- SSL certificates expire every 90 days
- HTTPS use domain name not ip
