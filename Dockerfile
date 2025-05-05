FROM ruby:3.2.2

ENV ROOT="/app"

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR ${ROOT}

COPY Gemfile ${ROOT}/Gemfile
COPY Gemfile.lock ${ROOT}/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . ${ROOT}

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3002

CMD ["rails", "server", "-b", "0.0.0.0"]