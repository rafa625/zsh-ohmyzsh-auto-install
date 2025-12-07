#!/bin/bash

set -e

echo "Executando purge completo do Zsh e Oh My Zsh..."

# --- REMOÇÃO DO ZSH ---
echo "Verificando instalação do Zsh..."
if dpkg -l | grep -q "^ii  zsh "; then
  echo "Zsh encontrado. Removendo..."
  sudo apt remove --purge -y zsh zsh-common
  echo "Zsh removido."
else
  echo "Zsh não está instalado."
fi

# --- REMOÇÃO DO OH MY ZSH ---
OMZ_DIR="$HOME/.oh-my-zsh"

echo "Verificando instalação do Oh My Zsh..."
if [ -d "$OMZ_DIR" ]; then
  echo "Oh My Zsh encontrado. Removendo..."
  rm -rf "$OMZ_DIR"
  echo "Oh My Zsh removido."
else
  echo "Oh My Zsh não está instalado."
fi

# --- REMOÇÃO DE ARQUIVOS DE CONFIG ---
echo "Removendo arquivos de configuração do Zsh..."

ZSH_FILES=(
  "$HOME/.zshrc"
  "$HOME/.zprofile"
  "$HOME/.zshenv"
  "$HOME/.zlogin"
  "$HOME/.zlogout"
)

for file in "${ZSH_FILES[@]}"; do
  if [ -f "$file" ]; then
    rm -f "$file"
    echo "Arquivo removido: $file"
  else
    echo "Arquivo não encontrado: $file"
  fi
done

echo "Purge concluído com sucesso."

