FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /dockApp
WORKDIR /dockApp
COPY Gemfile /dockApp/Gemfile
COPY Gemfile.lock /dockApp/Gemfile.lock
RUN bundle install
COPY . /dockApp