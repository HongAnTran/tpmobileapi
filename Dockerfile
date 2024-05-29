# Sử dụng image Node.js
FROM node:20-alpine

# Thiết lập thư mục làm việc
WORKDIR /app

# Cài đặt các dependency
COPY package*.json ./
RUN npm install

# Copy mã nguồn vào container
COPY . .

# Build project
RUN npm run build

# Cấu hình cổng và lệnh chạy ứng dụng
EXPOSE 3000
CMD ["npm", "run", "start:prod"]
