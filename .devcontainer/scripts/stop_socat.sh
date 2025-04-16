#!/bin/bash

# Encerra o processo socat que está redirecionando a porta 9090
if pgrep -f "socat TCP-LISTEN:9090" > /dev/null; then
    echo "Encerrando socat (redirecionamento 9090)..."
    pkill -f "socat TCP-LISTEN:9090"
else
    echo "Nenhum processo socat encontrado na porta 9090."
fi