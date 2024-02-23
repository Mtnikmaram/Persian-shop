from django.shortcuts import render

from blog.models import Post


# Create your views here.


def index(request):
    """A view to return the index page"""

    return render(request, 'home/index.html')


def blog_post(request):
    latest_posts = Post.objects.order_by('-date_published')[:5]

    return render(request, 'home/blog_post.html', {'latest_posts': latest_posts})