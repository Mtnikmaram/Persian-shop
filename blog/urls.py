from django.urls import path
from . import views


urlpatterns = [
    path('', views.post_list.as_view(), name='home'),
]
