SnapshoterVmWare разработано Hramoff. Позволяет откатывать виртуальные машины к любым снапшотам, попутно их перезагружая.

Полная инструкция запуска данного плейбука Ansible " apt-get install pip pip3 . pip3 install ansible venv PyPi. "

Далее необходимо установить зависимости "ansible-galaxy collection install community.vmware" Допускается объединение всех зависимостей в один pip3 install запрос

Файлом inventory.ini является инвентарный файл. ansible.cfg является аналогично файлом конфигурации.

файл с плейбуком называется 2-revetToSnapshot.yaml Боллее подробная информация об тот, как использовать плейбу находится в самом плейбуке :/

SnapshoterVmWare is developed by Hramoff. Allows you to roll back virtual machines to any snapshots, reloading them along the way. Full instructions for running this Ansible playbook. apt-get install pip pip3 . pip3 install ansible venv PyPi. "ansible-galaxy collection install community.vmware" It is allowed to combine all dependencies into one pip3 install request.

The inventory.ini file is an inventory file. ansible.cfg is likewise a configuration file.

the playbook file is called 2-revetToSnapshot.yaml More information on how to use the playbook is in the playbook itself :/