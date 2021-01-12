[Unit]
Description=FirstBoot-late
After=first-boot-complete.target
ConditionFileNotEmpty=/opt/thinclient/install/firstboot-late.sh

[Service]
ExecStart=/opt/thinclient/install/firstboot-late.sh
ExecStartPost=/bin/mv /opt/thinclient/install/firstboot-early.sh /opt/thinclient/install/firstboot-late.sh.done
Type=oneshot
RemainAfterExit=no

[Install]
WantedBy=multi-user.target
