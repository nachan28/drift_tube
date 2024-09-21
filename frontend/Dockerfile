FROM node:18 AS base

# Build stage
FROM base AS test-and-build
COPY . /app
WORKDIR /app
ARG VUE_APP_API_URL
RUN yarn install --frozen-lockfile && yarn build

# development stage
FROM test-and-build AS development
EXPOSE 5173
CMD ["yarn", "dev", "--host"]

# Hosting in Nginx
FROM nginx:latest AS production
COPY --from=test-and-build /app/dist /var/www
COPY nginx.conf /etc/nginx/conf.d/default.conf