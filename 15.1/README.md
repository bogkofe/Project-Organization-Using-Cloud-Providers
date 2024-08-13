# Ответы на занятие 'Организация сети'

## Задача 1
- Создал VPC и 2 subnet с именами private и public
- Так жк создал route table и добавил статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс

![image](https://github.com/mimimimimimimimimimimi/Project-Organization-Using-Cloud-Providers/blob/main/15.1/files/2.png)


- Создал nat-instance и 2 виртульные машины
![image](https://github.com/mimimimimimimimimimimi/Project-Organization-Using-Cloud-Providers/blob/main/15.1/files/1.png)

- Демонстрация что с машины public есть доступ в инет
![image](https://github.com/mimimimimimimimimimimi/Project-Organization-Using-Cloud-Providers/blob/main/15.1/files/3.png)

- Демонстрация что с машины private есть доступ в инет
![image](https://github.com/mimimimimimimimimimimi/Project-Organization-Using-Cloud-Providers/blob/main/15.1/files/4.png)

- Вся работа была выполнена через Terraform. Ниже ссылка на манифест
[terraform](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/tree/main/15.1/src)
