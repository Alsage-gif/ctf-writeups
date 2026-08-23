Проводим первоначальное сканирование сети.
![Pasted image 20260823142419.png](./brooklyn-nine-nine/assets/Pasted image 20260823142419.png)
Сразу бросается в глаза открытый ftp порт и nmap указал что в него можно зайти через anonymous.
![Pasted image 20260823142618.png](./brooklyn-nine-nine/assets/Pasted image 20260823142618.png)
Видим что на ftp лежит записка(Записка для Джейка)
Выгрузим её себе на систему.
![Pasted image 20260823143030.png](./brooklyn-nine-nine/assets/Pasted image 20260823143030.png)
![Pasted image 20260823143052.png](./brooklyn-nine-nine/assets/Pasted image 20260823143052.png)Перевод: "Джейк, пожалуйста, смени пароль. Он слишком слабый, и Холт будет в ярости, если кто-нибудь взломает систему 99-го участка."
На данный момент,это мало что дает,перейдем к 80 порту и зайдем на сайт.
![Pasted image 20260823143239.png](./brooklyn-nine-nine/assets/Pasted image 20260823143239.png)Перевод: "В этом примере создается фоновое изображение на всю страницу. Попробуйте изменить размер окна браузера, чтобы увидеть, как оно всегда заполняет весь экран (при прокрутке в самое начало) и корректно масштабируется на экранах любого размера."
Зайдем в DevTools "F12"
Видим подсказку
![Pasted image 20260823143408.png](./brooklyn-nine-nine/assets/Pasted image 20260823143408.png)
Скачаем картинку и попробуем ее изучить
![Pasted image 20260823144016.png](./brooklyn-nine-nine/assets/Pasted image 20260823144016.png)
ExifTool особо ничего не дал.Попробуем другой вариант со steghide.
![Pasted image 20260823144327.png](./brooklyn-nine-nine/assets/Pasted image 20260823144327.png)
Нужен пароль.Пробуем взаимодействовать через stegseek.
![Pasted image 20260823144740.png](./brooklyn-nine-nine/assets/Pasted image 20260823144740.png)
Как видим steegseek нам помог.
![Pasted image 20260823144849.png](./brooklyn-nine-nine/assets/Pasted image 20260823144849.png)
Выгрузим что было в картинке через steghide указав найденный пароль "admin"
![Pasted image 20260823144931.png](./brooklyn-nine-nine/assets/Pasted image 20260823144931.png)
Вот и пароль - "fluffydog12@ninenine"
Если вернуться назад,вспомним что открыт ssh,думаю стоит попробовать подключиться через него c полученными данными.
![Pasted image 20260823145409.png](./brooklyn-nine-nine/assets/Pasted image 20260823145409.png)
Найденный юзер не подходит,но в это сериале brokly 9-9,фамилия капитана пишется как **Holt**
user - holt
pass - fluffydog12@ninenine
![Pasted image 20260823145844.png](./brooklyn-nine-nine/assets/Pasted image 20260823145844.png)
Успех,знакомимся со системой и смотрим кто мы,где мы,и что нам можно.
![Pasted image 20260823145909.png](./brooklyn-nine-nine/assets/Pasted image 20260823145909.png)
Сразу забираем первый флаг
![Pasted image 20260823145947.png](./brooklyn-nine-nine/assets/Pasted image 20260823145947.png)
Видим что нам разрешена команда **nano** от имени root.Сращу же воспользуемся этим.
![Pasted image 20260823150110.png](./brooklyn-nine-nine/assets/Pasted image 20260823150110.png)
flag 1 - ee11cbb19052e40b07aac0ca060c23ee
flag 2 - 63a9f0ea7bb98050796b649e85481845

Lessons Learned

1.  **Steganography Automation:** В CTF-задачах на стеганографию всегда начинай с `stegseek` вместо `steghide`. Разница в скорости перебора словаря колоссальная (секунды против часов), особенно при использовании больших wordlist'ов вроде `rockyou.txt`.
2.  **Contextual Enumeration:** Не игнорируй подсказки в контенте сайта. Фраза "Look in the dark" и наличие одинокой картинки в DevTools были прямыми индикаторами скрытых данных. В пентестинге контекст важнее автоматического сканирования.
3.  **FTP Anonymous Access:** Открытый анонимный FTP — это часто не просто уязвимость, а источник первичной разведки. Записки, конфиги или старые бэкапы там встречаются чаще, чем прямые шеллы. Всегда проверяй права на запись/чтение.
4.  **Privilege Escalation via Editors:** Право запускать текстовые редакторы (`nano`, `vim`) от root эквивалентно полному доступу к системе. Это классическая misconfiguration, которую легко эксплуатировать через встроенные shell-команды (`:!sh` или `Ctrl+R Ctrl+E`).
5.  **Lateral Movement:** Успешный вход по SSH после получения пароля из стеганографии подтверждает важность проверки всех сервисов. Пароль, найденный в картинке, может быть ключом к другому пользователю (Holt), о котором нет явных упоминаний в веб-приложении.

