FROM ruby:3.3.0-alpine

RUN apk add --no-cache \
    git \
    curl

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "/usr/src/app/app.rb", "-o", "0.0.0.0"]
