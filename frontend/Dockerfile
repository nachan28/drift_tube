FROM node:18 AS base

CMD ["bash"]

# Build stage
FROM base AS test-and-build
COPY . /app
WORKDIR /app
ARG VUE_APP_API_URL
RUN yarn install --frozen-lockfile && yarn build

# Hosting in Nginx
FROM nginx:latest AS production
COPY --from=test-and-build /app/dist /var/www
COPY nginx.conf /etc/nginx/conf.d/default.conf