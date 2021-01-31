FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler:2.1.4
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

# FROM ruby:2.5.1 
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# RUN gem install bundler:2.1.4
# RUN mkdir /app
# WORKDIR /app 
# ADD Gemfile /app/Gemfile
# ADD Gemfile.lock /app/Gemfile.lock
# RUN bundle install
# ADD . /app


# FROM ruby:2.7.0

# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
#   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#   echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# RUN gem install bundler:2.1.4

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# RUN mkdir -p /app

# WORKDIR /app

# COPY Gemfile Gemfile.lock /app/

# RUN bundle install -j $(nproc)