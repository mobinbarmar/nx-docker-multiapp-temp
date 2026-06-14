FROM node:20-alpine

WORKDIR /workspace

# Copy package files first (for better caching)
COPY package*.json ./
COPY nx.json* ./
COPY tsconfig.base.json ./

# Install dependencies during build
RUN npm ci

# Copy source code
COPY apps/blog-service ./apps/blog-service
COPY libs ./libs

EXPOSE 3001 9229

CMD ["./node_modules/.bin/nx", "serve", "blog-service", "--host=0.0.0.0"]