
FROM ruby:3.2.2

# Install Depedencies
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && \
    apt-key add /root/yarn-pubkey.gpg && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs yarn libvips nano && \ 
    gem install rails bundler

# Default directory
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY . .

RUN bundle install && \
    yarn install

RUN RAILS_ENV=production bundle exec rake assets:precompile

# Start server
EXPOSE 8080
CMD bundle exec unicorn -c config/unicorn.rb