# syntax=docker/dockerfile:1
FROM ruby:3.0.2
#RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Ensure latest packages for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Allow apt to work with https-based sources
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
#COPY config/puma.rb /myapp/config/puma.rb

RUN bundle install
RUN yarn install

COPY . /myapp/

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ARG RAILS_ENV=development
RUN if [ "$RAILS_ENV" = "production" ]; then SECRET_KEY_BASE=$(rake secret) bundle exec rake assets:precompile; fi

# Configure the main process to run when running the image
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]