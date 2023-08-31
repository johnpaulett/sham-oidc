FROM --platform=$BUILDPLATFORM python:3.7-slim

LABEL maintainer="john@paulett.org"

WORKDIR /app

# Specifically add requirements.txt to use docker cache layer for `pip install`
# if requirements.txt is unchanged
ADD ./requirements.txt /app/requirements.txt
RUN pip install -U --require-hashes -r requirements.txt \
    && rm -rf /root/.cache/pip

ADD . /app/

# Short-term SECRET_KEY to allow collectstatic to run during image build
RUN SECRET_KEY=fake python manage.py collectstatic -v0 --noinput

# Workaround for loaddata in sqlite
#    django.db.utils.OperationalError: Problem installing fixtures: no such table: oidc_provider_client__old
#   https://gist.github.com/rririanto/d1dad8c3767d3995387496a41979c785
#   https://code.djangoproject.com/ticket/29182
#   https://github.com/django/django/pull/11986
RUN sed -i "s/execute('PRAGMA foreign_keys = 0')/execute('PRAGMA foreign_keys = 0'); c.execute('PRAGMA legacy_alter_table = ON')/"  /usr/local/lib/python3.7/site-packages/django/db/backends/sqlite3/schema.py

EXPOSE 8000
CMD python manage.py runserver 0.0.0.0:8000
