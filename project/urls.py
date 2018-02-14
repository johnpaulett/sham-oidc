from django.conf import settings
from django.conf.urls import url, include
from django.contrib import admin
from django.views.generic import RedirectView
from django.views.static import serve

from . import views


urlpatterns = [
    url(r'^$', views.index),
    url(r'^robots.txt$', views.robots),
    url(r'^accounts/', include('django.contrib.auth.urls')),

    # Use the normal login page, not the admin's login
    url(r'^admin/login/$', RedirectView.as_view(
        url=settings.LOGIN_URL, query_string=True
    )),
    url(r'^admin/', admin.site.urls),

    url(r'^openid/', include('oidc_provider.urls', namespace='oidc_provider')),

    # WARN: We use runserver to host the static content (not recommended)
    url(r'^static/(?P<path>.*)$', serve, {
        'document_root': settings.STATIC_ROOT,
    }),
]
