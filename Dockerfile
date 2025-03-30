# Sử dụng image Node.js chính thức
FROM node:18-alpine

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Sao chép file package.json và cài đặt dependencies
COPY package*.json ./
RUN npm install --production

# Sao chép toàn bộ mã nguồn
COPY . .

# Build ứng dụng NestJS
RUN npm run build

# Chạy ứng dụng
CMD ["node", "dist/main.js"]

# Mở cổng 4000
EXPOSE 4000