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

# Install dependencies
RUN npm install

# Copy application files
COPY . .

# Build Medusa and Admin
RUN npm run build && node_modules/.bin/medusa-admin build


# Expose port
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=development
ENV PORT=9000

# Start the application in development mode
CMD ["npm", "run", "dev"]
