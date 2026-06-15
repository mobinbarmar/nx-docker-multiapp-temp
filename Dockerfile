# ---- Builder ----
FROM node:20-alpine AS builder

ARG APP_NAME
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

RUN npx nx run ${APP_NAME}:build

# ---- Production ----
FROM node:20-alpine AS production

ARG APP_NAME
ARG PORT=3000
ENV PORT=${PORT} \
    NODE_ENV=production

WORKDIR /app

# The webpack build (generatePackageJson: true) emits a minimal package.json
# with only the prod deps actually used. Pair it with the root lockfile for
# reproducible installs via npm ci.
COPY --from=builder /app/dist/apps/${APP_NAME} .
COPY --from=builder /app/package-lock.json ./

RUN npm ci --omit=dev

EXPOSE ${PORT}

CMD ["node", "main.js"]
