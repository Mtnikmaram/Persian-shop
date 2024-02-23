from django.urls import path
from . import views
from blog.views import post_list

urlpatterns = [
    path('', views.index, name="home"),
   
]
