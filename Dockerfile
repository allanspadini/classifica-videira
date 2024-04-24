# Usar uma imagem base oficial do TensorFlow com suporte ao Python
FROM tensorflow/tensorflow:2.15.0

WORKDIR /app

# Instalar dependências básicas, se necessário
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clonar o repositório do projeto
RUN git clone https://github.com/allanspadini/classifica-videira.git .

# Instalar dependências Python do projeto
RUN pip3 install --no-cache-dir -r requirements.txt

# Expõe a porta 8501 usada pelo Streamlit
EXPOSE 8501

# Comando de verificação de saúde (ajustar se necessário)
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# Definir o comando de entrada para iniciar o Streamlit
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
