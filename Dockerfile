
# Stage 1: Build frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
COPY frontend/package*.js ./
COPY frontend/package*.html ./
COPY frontend/src/package*.jsx ./
COPY frontend/src/package*.css ./
RUN npm install
COPY frontend/ .
RUN npm run build

# Stage 2: Backend
FROM node:18 AS backend
WORKDIR /app
COPY backend/package*.json ./
COPY backend/package*.js ./
RUN npm install
COPY backend/ .

# Copy built frontend into backend's public folder
COPY --from=frontend-build /app/frontend/dist ./public

EXPOSE 3001
CMD ["node", "server.js"]
