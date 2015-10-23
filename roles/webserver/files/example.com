server {
	listen 80;
	server_name example.com www.example.com;
  
	root /var/www/html;

	index index.html index.htm index.php;

	gzip_static on;

	location = /favicon.ico {
		log_not_found off;
		access_log off;
	}

	location = /robots.txt {
		allow all;
		log_not_found off;
		access_log off;
	}

	location ~ /\.ht {
		deny all;
	}

	location ~ \..*/.*\.php$ {
		return 403;
	}

	location ~ (^|/)\. {
		return 403;
	}

	location / {
		try_files $uri $uri/ @rewrite;
	}

	location @rewrite {
		rewrite ^/(.*)$ /index.php;
	}

	location ~ \.php$ {
		include fastcgi.conf;
		set $path_info $fastcgi_path_info;
		fastcgi_index index.php;
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_param PATH_INFO $path_info;
		fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
		fastcgi_pass unix:/var/run/php5-fpm.sock;
		try_files $uri @rewrite;
	}

	location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
		expires max;
		log_not_found off;
	}
}
