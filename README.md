# docker-compose
My local docker-compose environment for a Laravel stack using PHP 7.1, Postgres, Redis, and nginx.

# Set Up
## Install Docker
```
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
```
More information about this script here: https://github.com/docker/docker-install

## Create a directory to serve your app in `public`
```
mkdir public/tomsisk.com
```

## Create nginx conf in `config/nginx`
```nginx
server {
    listen 80;
    server_name dev.tomsisk.com;
    root /var/www/html/tomsisk.com/public;

    access_log  /var/log/nginx/access.log main;
    error_log  /var/log/nginx/error.log;

    location / {
        try_files $uri /index.php?$query_string;
    }

    # Pass PHP scripts to PHP-FPM
    location ~* \.php$ {
        try_files $uri =404;

        fastcgi_index   index.php;
        fastcgi_pass    php-app:9000;

        include         fastcgi_params;
        fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }

    error_page 404 /index.php?$query_string; # serve missing files via PHP
}
```

## Edit your `/etc/hosts` file
```
127.0.0.1 dev.tomsisk.com
```

## Start your containers
```
docker-compose up -d
```

If your containers download and build correctly, you should now be able to access your application at http://dev.tomsisk.com
