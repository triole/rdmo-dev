server {
    listen 8280;
    server_name rdmo;

    location /static/ {
        alias /src/rdmo-app/static_root/;
    }

    location / {
        proxy_set_header Host $http_host;
        proxy_pass http://rdmo-upstream;
    }
}
