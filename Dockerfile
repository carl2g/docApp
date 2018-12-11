FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /home
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./
RUN rake db:migrate