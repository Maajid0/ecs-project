# Stage 1: Build
FROM node:23-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# Copy source files
COPY . .

# Build the app
RUN yarn build

# Stage 2: Production
FROM node:23-alpine

WORKDIR /app

# Install serve globally to serve static build files
RUN yarn global add serve

# Copy only the built files from the builder stage
COPY --from=builder /app/build ./build

# Expose port 3000 (default serve port)
EXPOSE 3000

# Start the app with serve serving the build folder
CMD ["serve", "-s", "build"]
