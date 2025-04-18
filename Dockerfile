# ---- Stage 1: Build the app ----
FROM node:22.14.0-alpine AS builder

WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the NestJS app
RUN npm run build

# ---- Stage 2: Production image ----
FROM node:22.14.0-alpine

WORKDIR /app

# Copy only the necessary files from the build stage
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Copy built files from the builder stage
COPY --from=builder /app/dist ./dist

# Expose the port the app runs on (adjust if needed)
EXPOSE 8081

# Start the NestJS application (adjust if using another port)
CMD ["node", "dist/main"]
