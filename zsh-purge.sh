#!/bin/bash

# Remover o Zsh e suas configurações
echo "Removendo Zsh e suas configurações..."

# Verificar se o Zsh está instalado
if dpkg -l | grep -q zsh; then
  sudo apt remove --purge -y zsh
  echo "Zsh removido."
else
  echo "Zsh não está instalado."
fi

# Remover o Oh My Zsh se estiver instalado
if [ -d "$HOME/.oh-my-zsh" ]; then
  rm -rf $HOME/.oh-my-zsh
  echo "Oh My Zsh removido."
else
  echo "Oh My Zsh não está instalado."
fi

# Remover arquivos de configuração do Zsh
for file in ~/.zshrc ~/.zprofile ~/.zshenv ~/.zlogin ~/.zlogout; do
  if [ -f "$file" ]; then
    rm "$file"
    echo "Arquivo $file removido."
  else
    echo "Arquivo $file não encontrado."
  fi
done

echo "Processo de remoção concluído."
