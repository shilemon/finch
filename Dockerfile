# Stage 1: Build the Vue.js app
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy built files
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom entrypoint script
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
