#!/bin/bash

set -e

echo "Executando zsh-purge.sh para limpar instalações anteriores..."
sudo ./zsh-purge.sh

echo "Atualizando pacotes e instalando dependências..."
sudo apt update -y
sudo apt install -y git curl

echo "Instalando Zsh..."
sudo apt install -y zsh

echo "Configurando Zsh como shell padrão..."
if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER"
fi

echo "Instalando Oh My Zsh..."
export RUNZSH=no

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh já existe. Pulando instalação."
fi

echo "Instalando plugins..."

PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# Garantir diretório
mkdir -p "$PLUGIN_DIR"

# --- Syntax Highlighting ---
if [ ! -d "$PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$PLUGIN_DIR/zsh-syntax-highlighting"
else
  echo "Plugin zsh-syntax-highlighting já existe."
fi

# --- Autosuggestions ---
if [ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$PLUGIN_DIR/zsh-autosuggestions"
else
  echo "Plugin zsh-autosuggestions já existe."
fi

echo "Aplicando alterações no .zshrc..."

ZSHRC="$HOME/.zshrc"

# Forçar tema bira
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="bira"/' "$ZSHRC"
else
  echo 'ZSH_THEME="bira"' >> "$ZSHRC"
fi

# Forçar lista de plugins
if grep -q '^plugins=' "$ZSHRC"; then
  sed -i 's|^plugins=.*|plugins=(git zsh-syntax-highlighting zsh-autosuggestions bun colorize docker docker-compose gulp node npm nvm)|' "$ZSHRC"
else
  echo 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions bun colorize docker docker-compose gulp node npm nvm)' >> "$ZSHRC"
fi

echo "Instalação concluída. Iniciando nova sessão Zsh..."
exec zsh

