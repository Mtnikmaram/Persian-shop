from django.shortcuts import render
from django.views import generic
from .models import Post


class post_list(generic.ListView):
    queryset = Post.objects.filter(status=1).order_by('-date_published')
    template_name = 'index.html'
    paginate_by = 3