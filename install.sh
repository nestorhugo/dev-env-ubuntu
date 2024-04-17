# ---------------- VARIAVEIS ---------

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'


PROGRAMAS_PARA_INSTALAR=(
  snapd
  git
  bashtop
)

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
sudo apt update -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

# ------- INSTALANDO OH MY ZSH ----------------
echo -e "${YELLOW}Iniciando instalação do OhMyZSH...${NC}"

sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# --------- INSTALANDO NVM ---------------------
echo -e "${YELLOW}Iniciando instalação do nvm/Node 20.12.2 ...${NC}"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
source ~/.zshrc
nvm install 20.12.2

# --------- INSTALANDO DOCKER -------------------
echo -e "${YELLOW}Iniciando instalação do Docker...${NC}"

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt-get install docker-compose-plugin
sudo usermod -aG docker $USER


# ----------Instalar programas no apt-----------
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    echo -e "${YELLOW}Iniciando instalação do $nome_do_programa ...${NC}"
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Flatpak ##
flatpak install flathub com.visualstudio.code -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub rest.insomnia.Insomnia -y
flatpak install flathub com.axosoft.GitKraken -y
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub org.gnome.Boxes -y

# --------------- CONFIGURAÇÃO DO GIT --------------------
echo -e "${YELLOW}Configurando o Git...${NC}"
echo -n -e "${YELLOW}Digite seu nome de usuário do GitHub: ${NC}"
read github_user
echo -n -e "${YELLOW}Digite seu e-mail associado ao GitHub: ${NC}"
read github_email

git config --global user.name "$github_user"
git config --global user.email "$github_email"

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y