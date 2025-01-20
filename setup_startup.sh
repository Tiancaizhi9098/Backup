#!/bin/bash
# 一键脚本：设置启动项和服务配置

# 赋予rc.local权限
sudo chown root:root /etc/rc.local
sudo chmod 755 /etc/rc.local

# 启用rc-local.service
sudo systemctl enable rc-local.service || echo "rc-local.service 可能没有安装配置，跳过"

# 创建systemd服务文件
cat <<EOF | sudo tee /etc/systemd/system/py_service.service
[Unit]
Description=Python Service
After=network.target

[Service]
Type=simple
ExecStart=/path/to/your/service.py
ExecReload=/path/to/your/service.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 启用py_service.service
sudo systemctl daemon-reload
sudo systemctl enable py_service.service

# 将脚本复制到 /etc/init.d 并添加到启动列表
sudo mv test /etc/init.d/test
sudo chmod 755 /etc/init.d/test
cd /etc/init.d
sudo update-rc.d test defaults 95

echo "所有步骤已完成！请确保路径已正确配置。"
