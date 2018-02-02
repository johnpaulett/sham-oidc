from django.http import HttpResponse
from django.shortcuts import render


def index(request):
    return render(request, 'index.html')


def robots(request):
    return HttpResponse('User-agent: *\nDisallow: /')
