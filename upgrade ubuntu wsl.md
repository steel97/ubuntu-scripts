Enable systemd on wsl
```bash
sudo nano /etc/wsl.conf
[boot]
systemd=true
```

Restart wsl
wsl.exe --shutdown
wsl

Upgrade ubuntu
sudo do-release-upgrade
