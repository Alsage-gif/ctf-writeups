#!/bin/bash
# Запускать из папки assets/ (там, где лежат Pasted_image_*.png)
# Убедись, что папка images/ существует: mkdir -p images

git mv "Pasted_image_20260823142419.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/01-nmap-scan.png"
git mv "Pasted_image_20260823142618.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/02-nmap-anonymous-ftp.png"
git mv "Pasted_image_20260823143030.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/03-ftp-note-download.png"
git mv "Pasted_image_20260823143052.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/04-ftp-note-content.png"
git mv "Pasted_image_20260823143239.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/05-website-main-page.png"
git mv "Pasted_image_20260823143408.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/06-devtools-hint.png"
git mv "Pasted_image_20260823144016.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/07-exiftool-output.png"
git mv "Pasted_image_20260823144327.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/08-steghide-password-required.png"
git mv "Pasted_image_20260823144740.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/09-stegseek-bruteforce.png"
git mv "Pasted_image_20260823144849.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/10-stegseek-found-password.png"
git mv "Pasted_image_20260823144931.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/11-steghide-extract-admin.png"
git mv "Pasted_image_20260823145409.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/12-ssh-attempt.png"
git mv "Pasted_image_20260823145844.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/13-ssh-success.png"
git mv "Pasted_image_20260823145909.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/14-system-enumeration.png"
git mv "Pasted_image_20260823145947.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/15-first-flag.png"
git mv "Pasted_image_20260823150110.png" "/home/alsage/ctf-writeups/tryhackme/brooklyn-nine-nine/images/16-nano-root-privesc.png"

echo "Готово. Проверь: git status"
