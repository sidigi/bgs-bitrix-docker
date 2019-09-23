up: docker-up

docker-up:
	docker-compose up --build -d

docker-clear:
	docker-compose down --remove-orphans

bitrix-projects-setup:
	docker-compose exec projects-php-fpm wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -O bitrixsetup.php
	make perm

bitrix-portal-setup:
	docker-compose exec portal-php-fpm wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -O bitrixsetup.php
	make perm

bitrix-projects-restore-download:
	docker-compose exec projects-php-fpm wget $(url)
	make perm

bitrix-projects-restore: bitrix-projects-restore-download
	docker-compose exec projects-php-fpm wget http://www.1c-bitrix.ru/download/scripts/restore.php -O restore.php
	make perm

bitrix-portal-restore-download:
	docker-compose exec portal-php-fpm wget $(url)
	make perm

bitrix-portal-restore: bitrix-portal-restore-download
	docker-compose exec portal-php-fpm wget http://www.1c-bitrix.ru/download/scripts/restore.php -O restore.php
	make perm

perm:
	sudo chgrp -R ${USER} projects portal
	sudo chown -R ${USER}:${USER} projects portal
	sudo chmod -R ug+rwx projects portal
