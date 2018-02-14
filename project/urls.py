from django.conf import settings
from django.conf.urls import url, include
from django.contrib import admin
from django.views.generic import RedirectView

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
]
