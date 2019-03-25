server {
        listen 80;
        server_name domain.io www.domain.io;
        return 301 https://domain.io$request_uri;
}

server {
        listen [::]:443 ssl http2 ipv6only=on; 
        listen 443 ssl http2; 
        server_name domain.io www.domain.io;

        #ssl on;

        #ssl_certificate /etc/nginx/ssl/certificates/domain.crt;
        #ssl_certificate_key /etc/nginx/ssl/certificates/domain.key;

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
        ssl_ecdh_curve secp384r1;
        ssl_session_timeout 10m;
        ssl_session_cache shared:SSL:10m;
        ssl_session_tickets off;
        ssl_stapling on;
        ssl_stapling_verify on;
        resolver 8.8.8.8 8.8.4.4 valid=300s;
        resolver_timeout 5s;

        ssl_dhparam /etc/nginx/ssl/certificates/dhparam.pem;

        add_header Strict-Transport-Security "max-age=31536000" always;
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";
#       add_header X-Robots-Tag none;

        gzip_comp_level    5;
        gzip_min_length    256;
        gzip_proxied       any;
        gzip_vary          on;
        gzip               on;

        gzip_types
        text/css
        text/javascript
        text/xml
        application/javascript
        application/json
        text/json
        text/html
        application/atom+xml
        application/javascript
        application/json
        application/ld+json
        application/manifest+json
        application/rss+xml
        application/vnd.geo+json
        application/vnd.ms-fontobject
        application/x-font-ttf
        application/x-web-app-manifest+json
        application/xhtml+xml
        application/xml
        font/opentype
        image/bmp
        image/svg+xml
        image/x-icon
        text/cache-manifest
        text/css
        text/plain
        text/vcard
        text/vnd.rim.location.xloc
        text/vtt
        text/x-component
        text/x-cross-domain-policy;

        location / {
                proxy_pass http://localhost:3000/;
        }

        location /assets/ {
                proxy_pass http://localhost:3000/assets/;
        }

    location /api/ {
                proxy_pass http://localhost:8080/api/;
        }

    location /img/ {
                proxy_pass http://localhost:8080/img/;
        }
}
         
