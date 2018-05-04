FROM ruby:2.3-jessie

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' >> /etc/apt/sources.list.d/postgresql.list \
  && wget --no-check-certificate -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O- | apt-key add - \
  && apt-get update

RUN apt-get -y install sudo postgresql-9.5 redis-server nodejs

COPY start-yolo.sh /start-yolo.sh
COPY reset-db.sh /reset-db.sh

COPY postgresql.conf /var/lib/pgsql/9.5/data/postgresql.conf
COPY pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf

RUN /etc/init.d/redis-server start
USER postgres
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER root WITH SUPERUSER;" &&\
    createdb -O root root
USER root

RUN mkdir /app
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --gemfile /app/Gemfile
RUN rm /app/Gemfile /app/Gemfile.lock

COPY start-yolo.sh /start-yolo.sh
COPY reset-db.sh /reset-db.sh

RUN chmod +x /start-yolo.sh
RUN chmod +x /reset-db.sh
