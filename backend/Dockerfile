# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
ARG ENVIRONMENT
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /app

# Set production environment
ENV RAILS_ENV=$ENVIRONMENT \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"


# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/


# Development stage
FROM base AS development

# Install development dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-dev libvips build-essential libgmp-dev

# Copy application code
COPY . .

# Install gems (including development gems)
RUN bundle install

# Expose the default Rails port for development
EXPOSE 8080

# Start the Rails server in development mode

# Final stage for app image
FROM base AS production

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["bash", "-c", "rm -f /app/tmp/pids/server.pid && exec ./bin/rails server -p 8080 -b '0.0.0.0'"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 8080
CMD ["./bin/rails", "server", "-p", "8080", "-b", "0.0.0.0"]
