"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/dev/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Import the include() function: from django.conf.urls import url, include
    3. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import url, include
from django.urls import path
from . import views 
from personal.controller import contDocumentFront 
from django.views.generic import TemplateView
app_name = 'main'
urlpatterns = [
    path("", TemplateView.as_view(template_name='document.html')),
    path("Admin/Transaction/Document", TemplateView.as_view(template_name='document.html'), name='admin'),
    path("Admin/Transaction/Document/remove", views.removeDocument),
    path("Admin/Transaction/Document/save", views.saveDocument),
    path("Admin/Transaction/Document/update", views.updateDocument),
    path("Admin/Transaction/Document/status", views.updateStatusDocument),
    path("API/Document", views.getDocumentList),
    path("API/Document/Item", views.getDocumentItem),
    path("API/Student", views.getStudentList),
    path("API/Employee", views.getEmployeeList),
    path("API/Category", views.getCategoryList),
    path("API/Type", views.getTypeList),
]
