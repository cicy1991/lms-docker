FROM daocloud.io/lamozarax/ubuntu-boostrap
MAINTAINER lamozarax dev@xiaogu-tech.com

RUN mkdir -p /root/.ssh/
# COPY ./deploy/known_hosts/ /root/.ssh/known_hosts
COPY ./deploy/id_rsa /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa

# ENV SITENAME=xg-tech-lms.daoapp.io
# ARG SITENAME=xg-tech-lms.daoapp.io

# RUN mkdir -p /sites/$SITENAME/
# RUN git clone git@git.oschina.net-lms:xiaogu-tech/laioffer-lms.git /sites/$SITENAME/
# RUN pip install -r /sites/$SITENAME/deploy_tools/requirements/staging.txt
# ENV DJANGO_SETTINGS_MODULE=config.settings_staging
# RUN locale-gen en_US en_US.UTF-8
# ENV LC_ALL="en_US.UTF-8"

# # DB related start
# USER postgres
# RUN    /etc/init.d/postgresql start &&\
# 	psql --command "CREATE DATABASE lms;" &&\
# 	psql --command "CREATE USER lmsuser WITH PASSWORD 'password';" &&\
# 	psql --command "ALTER ROLE lmsuser SET client_encoding TO 'utf8';" &&\
# 	psql --command "ALTER ROLE lmsuser SET default_transaction_isolation TO 'read committed';" &&\
# 	psql --command "ALTER ROLE lmsuser SET timezone TO 'UTC';" &&\
# 	psql --command "GRANT ALL PRIVILEGES ON DATABASE lms TO lmsuser;"

# RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf
# USER root
# # RUN sh /sites/$SITENAME/misc/cleanup.sh
# # DB related end


# WORKDIR /sites/$SITENAME/
# RUN pwd
# RUN git pull origin master

# WORKDIR source
# # gunicorn --bind unix:/tmp/$SITENAME.socket config.wsgi:application

# # nginx related
# COPY ./deploy/nginx.conf /etc/nginx/sites-available/lms.conf
# RUN mv /etc/nginx/sites-available/lms.conf /etc/nginx/sites-available/$SITENAME
# RUN sed -i "s/SITENAME/$SITENAME/g" /etc/nginx/sites-available/$SITENAME
# RUN ln -s /etc/nginx/sites-available/$SITENAME /etc/nginx/sites-enabled/$SITENAME
# RUN rm /etc/nginx/sites-enabled/default
# RUN python manage.py collectstatic --noinput
# # nginx related end

# # USER postgres
# # EXPOSE 5432
# # CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/etc/postgresql/9.5/main/"]

# COPY ./deploy/start.sh /sites/start.sh
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]