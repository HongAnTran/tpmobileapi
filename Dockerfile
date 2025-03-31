# Sử dụng image Node.js chính thức
FROM node:20-alpine

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Sao chép file package.json và cài đặt dependencies
COPY package*.json ./
RUN npm install 

COPY . .

RUN npm uninstall bcrypt

RUN npm install bcrypt
RUN npx prisma generate
# Build ứng dụng NestJS
RUN npm run build

# Chạy ứng dụng
CMD ["npm", "start:prod"]

# Mở cổng 4000
EXPOSE 4000