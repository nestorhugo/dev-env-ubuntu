# dev-env-ubuntu

Script para instalação inicial em um sistema ubuntu após formatação

Para fazer funcionar, primeiro instale o flatpak e reinicie sua máquina

```bash
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

```bash

bash  -c  "$(curl  -fsSL https://raw.githubusercontent.com/nestorhugo/dev-env-ubuntu/main/install.sh) && chmod +x install.sh && ./install.sh"

```
