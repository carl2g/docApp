FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /docApp
WORKDIR /docApp
COPY Gemfile /docApp/Gemfile
COPY Gemfile.lock /docApp/Gemfile.lock
RUN bundle install
COPY . /docApp
RUN rake db:migrate
