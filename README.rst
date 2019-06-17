sham-oidc
=========

sham-oidc is a simple, **unsecure** OpenID Connect (OIDC) Provider, useful for
locally testing another application that is an OpenID Connect Relying Party.

The container can be run by pulling the `johnpaulett/sham-oidc
<https://hub.docker.com/r/johnpaulett/sham-oidc/>`_ image or by checking
out the git repository and using the included docker-compose.yml.

Utilizes `django-oidc-provider <https://django-oidc-provider.readthedocs.io>`_,
providing a simple containerized wrapper with the minimal set of
templates and configuration to quickly get started.

sham-oidc is **not** intended for production or public usage.

Environment Setup
-----------------

It is suggested that you create a .env file or set a `SECRET_KEY` environment
variable.

``.env``::

   SECRET_KEY=<create a secret key>

There are several additional support environment variables::

   DEBUG=true
   DISABLE_PASSWORD_VALIDATORS=true

Run by Pulling the Image
------------------------

Sample for including in your own docker-compose.yml::

  oidc:
    image: "johnpaulett/sham-oidc"
    ports:
      - "4000:8000"
    volumes:
      - oidc-db:/data
    environment:
      - SECRET_KEY=${SECRET_KEY}

  volumes:
    oidc-db:

The sqlite database will be stored in the volume, allowing credentials to
persist across time

Run from the Repository
-----------------------

::

   git clone https://github.com/johnpaulett/sham-oidc
   cd sham-oidc
   docker-compose up --build

django-oidc-provider's settings can be modified in ``project/settings.py``


Container Setup
---------------

You will need to run the database migrations, create an RSA key (if using RS256
instead of HS256), and create a super user for the Django Admin::

  docker-compose run oidc ./manage.py migrate
  docker-compose run oidc ./manage.py creatersakey
  docker-compose run oidc ./manage.py createsuperuser


Client Setup
------------

Navigate to http://localhost:4000/admin/ to create a Client. See
`django-oidc-provider <https://django-oidc-provider.readthedocs.io>`_ for
documentation on how to create a client.


- https://hub.docker.com/r/johnpaulett/sham-oidc/
- https://github.com/johnpaulett/sham-oidc
