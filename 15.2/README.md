# Ответы на занятие 'Вычислительные мощности. Балансировщики нагрузки'

## Задача 1
- Создал бакет Object Storage и разместил в нём файл с картинкой
- И сделал файл доступным из интернета
![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/1.png)


- Создал группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:
![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/2.png)

- Подключил группу к сетевому балансировщику
![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/3.png)

![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/4.png)


- Демонстрация что при переходе по ip адресу балансировчщика открывается моя картинка из бакета
![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/5.png)

- Отключил 2 виртуальные машины, при переходе так же открывается картинка из бакета, значит балансировщик работает
![image](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/blob/main/15.2/files/6.png)

- Ниже сслыка на манифест
[terraform](https://github.com/bogkofe/Project-Organization-Using-Cloud-Providers/tree/main/15.2/src/main_15.2.tf)
