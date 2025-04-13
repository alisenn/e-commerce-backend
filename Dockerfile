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

# Install Medusa CLI globally
RUN npm install -g @medusajs/medusa-cli

# Copy package files
COPY package.json ./

# Install production dependencies
RUN npm install --legacy-peer-deps --production

# Copy application files
COPY . .

# Build Medusa
RUN npm run build

# Expose port
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=9000

# Start the application in production mode
CMD ["npm", "start"]
