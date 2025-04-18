# ---- Stage 1: Build the app ----
FROM node:22.14.0-alpine AS builder

WORKDIR /app

# Install OpenSSL (required for Prisma client on Alpine)
RUN apk add --no-cache openssl

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies including Prisma CLI
RUN npm install

# Copy the rest of the application
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build the NestJS app
RUN npm run build

# ---- Stage 2: Production image ----
FROM node:22.14.0-alpine

WORKDIR /app

# Install OpenSSL again for Prisma client runtime
RUN apk add --no-cache openssl

# Copy only necessary files
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Copy Prisma files (needed at runtime for client + env)
COPY --from=builder /app/prisma ./prisma

# Copy built app and generated Prisma client
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma

# Expose app port
EXPOSE 8081

# Start the app
CMD ["node", "dist/main"]
