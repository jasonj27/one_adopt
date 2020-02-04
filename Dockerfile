FROM ruby:2.6-alpine AS build-env
ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=dumb

WORKDIR $RAILS_ROOT

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES
COPY Gemfile* package.json yarn.lock ./
# install rubygem
COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN gem install bundler:2.1.4
RUN bundle config --global frozen 1 \
    && bundle config set without 'development:test:assets' \
    && bundle install -j4 --retry 3 \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete
RUN yarn install --production
COPY . .
# RUN bin/rails webpacker:compile
RUN bin/rails assets:precompile
# Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache vendor/assets spec
############### Build step done ###############
FROM ruby:2.6-alpine
ARG RAILS_ROOT=/app
ARG PACKAGES="tzdata postgresql-client nodejs bash"
ENV RAILS_ENV=production

WORKDIR $RAILS_ROOT
# install packages
RUN apk add --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community --repository http://dl-3.alpinelinux.org/alpine/edge/main vips-dev
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES
COPY --from=build-env /usr/local/bundle/ /usr/local/bundle/
COPY --from=build-env $RAILS_ROOT $RAILS_ROOT
EXPOSE $PORT