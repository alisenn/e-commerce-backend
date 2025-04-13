# Base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    postgresql-client

# Copy package files
COPY package.json ./

# Install dependencies (This will generate package-lock.json)
RUN npm install

# Copy application files
COPY . .

# Build the application
RUN npm run build

# Expose port
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=9000

# Start the application
CMD ["npm", "start"]
