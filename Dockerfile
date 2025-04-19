# Use the official Node.js image as the base image
FROM node:23

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the NestJS application
RUN npm run build

# Solves bad gateway issue
ENV HOST=0.0.0.0

ENV PORT=8082

# Expose the application port
EXPOSE 8082

# Command to run the application
CMD ["node", "dist/main"]
