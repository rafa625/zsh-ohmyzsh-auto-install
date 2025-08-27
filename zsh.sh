#!/bin/bash

# Chamar o zsh-purge.sh antes da instalação
echo "Executando zsh-purge.sh para limpar instalações anteriores..."
sudo ./zsh-purge.sh

# Instalação de dependências (Git e Curl)
echo "Instalando dependências..."
sudo apt update
sudo apt install -y git curl

# Instalação do Zsh
echo "Instalando Zsh..."
sudo apt install -y zsh

# Definir Zsh como shell padrão
echo "Configurando Zsh como shell padrão..."
sudo chsh -s $(which zsh) $USER

# Instalação do Oh My Zsh
echo "Instalando Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalação de plugins do Oh My Zsh
echo "Instalando plugins do Oh My Zsh..."

# Clonar o repositório do zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Clonar o repositório do zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Atualizar o arquivo .zshrc para incluir os plugins
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions bun colorize docker docker-compose gulp node npm nvm)/' ~/.zshrc

# Atualização das configurações do Zsh ao iniciar uma nova sessão Zsh
echo "Instalação concluída. Iniciando uma nova sessão Zsh para aplicar as mudanças..."
zsh -c "source ~/.zshrc && exec zsh"
