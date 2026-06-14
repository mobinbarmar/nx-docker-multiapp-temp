FROM node:20-alpine

WORKDIR /workspace

# Copy package files first (for better caching)
COPY package*.json ./
COPY nx.json* ./
COPY tsconfig.base.json ./

# Install dependencies during build
RUN npm ci

# Copy source code
COPY apps/api-gateway ./apps/api-gateway
COPY libs ./libs

EXPOSE 3000 9229

# No need to run npm ci again in command
CMD ["./node_modules/.bin/nx", "serve", "api-gateway", "--host=0.0.0.0"]