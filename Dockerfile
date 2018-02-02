FROM python:3.6

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

EXPOSE 8000
CMD python manage.py runserver 0.0.0.0:8000
