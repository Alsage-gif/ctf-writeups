# ColddBox — WordPress и SUID `find`

## Разведка WordPress

На хосте обнаружил WordPress. Поведение формы входа и версия CMS указывали на устаревшую установку.

![Главная страница WordPress](../images/Pasted%20image%2020260318195912.png)

![Форма входа WordPress](../images/Pasted%20image%2020260318200010.png)

При перечислении пользователей обнаружил логин `c0ldd`.

![Обнаруженный пользователь c0ldd](../images/Pasted%20image%2020260319133005.png)

Проверил пароль через WPScan:

```bash
wpscan --url http://10.112.167.160/wp-login.php \
  -U c0ldd \
  -P /usr/share/wordlists/rockyou.txt \
  --no-update
```

![Запуск подбора пароля WPScan](../images/Pasted%20image%2020260319145645.png)

![Результат подбора учётных данных](../images/Pasted%20image%2020260319150534.png)

## Получение shell

Использовал найденный доступ к WordPress для загрузки PHP-пayload и получения reverse shell.

![Загрузка payload в архиве](../images/Pasted%20image%2020260319151845.png)

![Полученный shell](../images/Pasted%20image%2020260319152343.png)

После этого стабилизировал терминал.

![Стабилизированный терминал](../images/Pasted%20image%2020260319152457.png)

## Повышение привилегий

В списке доступных SUID-файлов обнаружил `/usr/bin/find`.

![Найденный SUID-бинарник find](../images/Pasted%20image%2020260319152705.png)

Так как `find` принадлежал root и имел SUID-бит, использовал его `-exec` для запуска привилегированной оболочки:

```bash
find . -exec /bin/sh -p \; -quit
```

Флаг `-p` не позволяет оболочке сбросить эффективные привилегии.

![Получение root через SUID find](../images/Pasted%20image%2020260319153022.png)

## Итог

1. Определил WordPress.
2. Нашёл пользователя `c0ldd` и подобрал пароль через WPScan.
3. Получил reverse shell через загрузку PHP-файла.
4. Нашёл SUID `find`.
5. Запустил `/bin/sh -p` и получил root.
