# Jmeter Cluster Support for Kubernetes and OpenShift

## Prerequisits

Kubernetes > 1.16

OpenShift version > 3.5

## TL;DR

```bash
./dockerimages.sh
./jmeter_cluster_create.sh
./dashboard.sh
./start_test.sh
```

Please follow the guide "Load Testing Jmeter On Kubernetes" on our medium blog post:

https://goo.gl/mkoX9E

## Windows 用户使用指南

系统要求 Windows 10

1. 安装 Windows 子系统, 例如: [Ubuntu](https://www.microsoft.com/store/productId/9NBLGGH4MSV6)
2. 安装 [Windows Terminal](https://www.microsoft.com/store/productId/9n0dx20hk701)
3. 在 Windows Terminal 中启动 Ubuntu, 安装并配置 kubectl

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

4. 安装并配置其它命令工具

```bash
sudo apt-get install -y make git zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "export EDITOR=vim;" >> ~/.profile
```

5. 保存 kubectl 运行配置 ~/.kube/config
6. 在 grafana 中导入 dashboard 模板配置文件 GrafanaJMeterTemplate.json
7. 修改 dashboard 生成 pdf link 地址

### 常用指令

1. 创建系统

```bash
    make create
```

2. 删除系统

```bash
    make delete
```

3. 重新创建系统

```bash
    make reload
```

4. 测试用例

```bash
    ./start_test.sh sample.jmx
```

5. 停止运行中的测试

```bash
    ./stop_test.sh
```
