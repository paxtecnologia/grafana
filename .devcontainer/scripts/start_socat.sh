#!/bin/bash
# Descobre o IP da bridge Docker (docker0)
HOST_IP=$(ip -4 addr show docker0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -z "$HOST_IP" ]; then
    echo "Erro: Não foi possível obter o IP da bridge Docker."
    exit 1
fi

echo "IP da bridge Docker: $HOST_IP"
echo "Iniciando socat (redirecionando $HOST_IP:9090 -> 127.0.0.1:9090)..."

# Verifica se o socat já está rodando para evitar duplicatas
if ! pgrep -f "socat TCP-LISTEN:9090.*TCP:127.0.0.1:9090" > /dev/null; then
    # Usando setsid para desvincular completamente do terminal
    setsid socat TCP-LISTEN:9090,fork,reuseaddr,bind="$HOST_IP" TCP:127.0.0.1:9090 </dev/null &>/dev/null &
    
    # Verificação adicional para confirmar que o processo está rodando
    sleep 1
    if pgrep -f "socat TCP-LISTEN:9090.*TCP:127.0.0.1:9090" > /dev/null; then
        echo "socat iniciado com sucesso em background."
    else
        echo "Falha ao iniciar socat."
        exit 1
    fi
else
    echo "socat já está rodando."
fi

echo "Iniciando socat (redirecionando $HOST_IP:8081 -> 127.0.0.1:8081)..."

# Verifica se o socat já está rodando para evitar duplicatas
if ! pgrep -f "socat TCP-LISTEN:8081.*TCP:127.0.0.1:8081" > /dev/null; then
    # Usando setsid para desvincular completamente do terminal
    setsid socat TCP-LISTEN:8081,fork,reuseaddr,bind="$HOST_IP" TCP:127.0.0.1:8081 </dev/null &>/dev/null &
    
    # Verificação adicional para confirmar que o processo está rodando
    sleep 1
    if pgrep -f "socat TCP-LISTEN:8081.*TCP:127.0.0.1:8081" > /dev/null; then
        echo "socat iniciado com sucesso em background."
    else
        echo "Falha ao iniciar socat."
        exit 1
    fi
else
    echo "socat já está rodando."
fi