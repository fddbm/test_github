FROM gcc:latest as build

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    libpqxx-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
