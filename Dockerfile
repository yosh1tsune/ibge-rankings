FROM ruby:3.2.2-alpine

RUN apk update && apk upgrade

RUN apk add --update --no-cache build-base tzdata bash vim

RUN mkdir /app
WORKDIR /app

COPY . /app

COPY Gemfile* app/

RUN gem update --system

RUN bundle install

CMD ["ruby", "lib/app.rb"]
