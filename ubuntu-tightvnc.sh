sudo apt update
sudo apt install xfce4 xfce4-goodies
sudo apt install tightvncserver
sudo vncserver
# ask to select password
sudo vncserver -kill :1
sudo mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

sudo cat << EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF

sudo chmod +x ~/.vnc/xstartup

sudo cat << EOF > /etc/systemd/system/vncserver@.service
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=root
Group=root
WorkingDirectory=/home/root

PIDFile=/home/root/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1