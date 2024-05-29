# Используем официальный Node.js образ как базовый
FROM node:16

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json в контейнер
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем оставшиеся файлы в контейнер
COPY . .

# Строим Nuxt.js приложение
RUN npm run build

# Устанавливаем переменные окружения для Nuxt
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

# Открываем порты для Nuxt.js и сервера
EXPOSE 3000 3001

# Запускаем оба сервиса через `concurrently`
CMD ["npx", "concurrently", "\"npm run start-nuxt\"", "\"npm run start-server\""]