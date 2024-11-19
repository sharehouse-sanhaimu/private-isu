.PHONY: init
init: webapp/sql/dump.sql.bz2 benchmarker/userdata/img

webapp/sql/dump.sql.bz2:
	cd webapp/sql && \
	curl -L -O https://github.com/catatsuy/private-isu/releases/download/img/dump.sql.bz2

benchmarker/userdata/img.zip:
	cd benchmarker/userdata && \
	curl -L -O https://github.com/catatsuy/private-isu/releases/download/img/img.zip

benchmarker/userdata/img: benchmarker/userdata/img.zip
	cd benchmarker/userdata && \
	unzip -qq -o img.zip

create-nginx-link:
	mv /etc/nginx /etc/nginx.bak
	ln -s /home/isucon/private_isu/etc/nginx/ /etc/
	systemctl restart nginx.service

delete-nginx-link:
	rm /etc/nginx

create-mysql-link:
	sudo ln -s /home/isucon/private-isu/etc/mysql/conf.d/my.cnf/ /etc/mysql/conf.d/

list-daemon:
	mkdir -p daemon_list
	timestamp=$(date "+%Y%m%d_%H%M%S")
	systemctl list-units --type=service --state=running

lint-mysql:
	mysqld --validate-config

