FROM ruby:3.4.2-alpine

RUN apk add --no-cache \
    git \
    curl

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
WORKDIR /usr/src/app

ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . /usr/src/app

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "/usr/src/app/app.rb", "-o", "0.0.0.0"]
