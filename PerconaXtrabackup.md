Создание бекапов Percona XtraBackup
---


## Добавление репозитория

https://docs.percona.com/percona-xtrabackup/2.4/installation/apt_repo.html#whats-in-each-deb-package

```shell
deb http://repo.percona.com/percona/apt buster main
deb-src http://repo.percona.com/percona/apt buster main
deb http://repo.percona.com/prel/apt buster main
deb-src http://repo.percona.com/prel/apt buster main
```

## Для компрессии установить qpress
```shell
apt install qpress
```

## Установить Percona Xtrabackup

https://www.percona.com/downloads

## Снятие бекапа
```shell
xtrabackup --backup --compress --compress-threads=4  --target-dir=/backup/ --compress-zstd-level=3 --user=root --password
```

### Можно указать конкретную базу `--database=MYDB`

## Скопировать бекап на хост

## Распаковать бекап
```shell
xtrabackup --decompress --target-dir=/backup/
```

Нужен установленный qpress

## Подготовить базу 
```shell
xtrabackup --prepare --target-dir=/backup/
```

## Восстановить базу 
```shell
xtrabackup --copy-back --target-dir=/backup/
```

Каталог хранения базы mysql берется из my.cnf

## Выдать права нормальные
```shell
chown -R mysql:mysql /var/lib/mysql
```

## Может потребовать переименовать базу
```shell
mysql -uroot -pPASS -e "CREATE DATABASE \`NEW_DB\`;"
for table in `mysql -uroot -pPASS -B -N -e "SHOW TABLES;" ODL_DB`
do 
  mysql -uroot -pPASS -e "RENAME TABLE \`ODL_DB\`.\`$table\` to \`NEW_DB\`.\`$table\`"
done
```
