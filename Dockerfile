# Stage 1: Build the project
FROM node:20-alpine AS builder

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy các file cần thiết và cài đặt dependencies
COPY package*.json ./
RUN npm install

# Copy toàn bộ mã nguồn vào container
COPY . .

# Build project
RUN npm run build

# Stage 2: Production
FROM node:20-alpine

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy chỉ các file cần thiết từ stage build trước
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

# Cài đặt các dependency production
RUN npm install --production

# Cấu hình cổng và lệnh chạy ứng dụng
EXPOSE 4000
CMD ["npm", "run", "start:prod"]
