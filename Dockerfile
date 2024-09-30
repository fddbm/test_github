FROM gcc:latest as build

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    libpqxx-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копирование исходного кода
COPY . .

# Сборка проекта
RUN mkdir build && cd build && \
    cmake .. && \
    make
# Финальный образ
FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
    libpqxx-6.2 \
    libboost-system1.67.0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копирование собранного приложения из предыдущего этапа
COPY --from=build /app/build/FunnyBetsService .

EXPOSE 8080

CMD ["./FunnyBService"]
