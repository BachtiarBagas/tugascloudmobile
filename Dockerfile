# Gunakan image Node.js 18 untuk build
FROM node:18-alpine AS builder

# Set folder kerja
WORKDIR /app

# Copy package.json dan 
COPY package.json  ./

# Install dependencies dengan npm
RUN npm install

# Copy sisa kode aplikasi
COPY . .

# Jalankan perintah build (akan membuat folder 'build')
RUN npm run build

# --- TAHAP 2: PRODUKSI ---
# Gunakan image Nginx (server web) yang ringan
FROM nginx:1.25-alpine

# Copy HANYA folder 'build' yang sudah jadi dari tahap 'builder' ke folder Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Ekspos port 80 (port default Nginx)
EXPOSE 80

# Perintah untuk menjalankan server Nginx
CMD ["nginx", "-g", "daemon off;"]