readlink -f $(which java) | sed s:bin/java::    == Получить $JAVA_HOME
find / -name file*.file                         == Найти файл по имени
:%s/^#.*$//g                                    == удаляет комментарии
:%s/\n\{2,}/\r/g                                == удаляет пустые строки
"{{ groups['YOU_GROUPS'] | join(', ') }}"       == Перебор всех хостов в группе Ansible. Join разделяет хосты точкой с пробелом
du -ah / | sort -rh | head -n 10                == Вывод 10 самых больших файлов в ФС

CREATE USER 'username'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%';
FLUSH PRIVILEGES;                                      == Создание пользователя MySQL

SELECT table_schema AS "Database", 
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)"
FROM information_schema.tables 
GROUP BY table_schema;                          == Вес БД в МБ


ansible-vault encrypt_string 'password' --name 'var_name'     == создание хеша vault
grep -rnw / -e "СТРОКА ПОИСКА"                 == Поиск во всех файлах по строке


mysqldump -u USER -p -R -v "ИМЯ БАЗЫ ДАННЫХ" > "ИМЯ БАЗЫ ДАННЫХ".sql; gzip "ИМЯ БАЗЫ ДАННЫХ".sql     == Дамп mysql базы. -R с процедурами и триггерами
gzip -d "ИМЯ БАЗЫ ДАННЫХ".sql                   == Распаковать gz архив
mysql -u USER -p -v "ИМЯ БАЗЫ ДАННЫХ" < "ИМЯ БАЗЫ ДАННЫХ".sql   == Вернуть дамп MySQL


truncate -s 0 /var/lib/docker/containers/*/*-json.log удалить содержимое файла, без удаления самого файла



`root@vps:~# parted /dev/sda`
GNU Parted 3.2
Using /dev/vda
Welcome to GNU Parted! Type 'help' to view a list of commands.
`(parted) print`                                         
Model: Virtio Block Device (virtblk)
Disk /dev/vda: 6442MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  5369MB  5368MB  primary  ext4         boot

`(parted) resizepart`
`Partition number? 1`   << the number of the partition you want resize
Warning: Partition /dev/vda1 is being used. Are you sure you want to continue?
`Yes/No? Yes`
`End?  [5369MB]? 100% `   << 100% means we want use all the space available

`(parted) print   `                   
Model: Virtio Block Device (virtblk)
Disk /dev/vda: 6442MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  6442MB  6441MB  primary  ext4         boot

`(parted) q`                
Information: You may need to update /etc/fstab.


`resize2fs /dev/vda1`
