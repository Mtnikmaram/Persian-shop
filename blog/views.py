from django.shortcuts import render, get_object_or_404, reverse, redirect
from django.views import generic, View
from django.http import HttpResponseRedirect
from .models import Post, User
from .forms import PostForm

class post_list(generic.ListView):
    queryset = Post.objects.filter(status=1).order_by('-date_published')
    template_name = 'index.html'
    paginate_by = 3

class PostDetail(View):
    def get(self, request, slug, *args, **kwargs):
        post = get_object_or_404(Post, slug=slug)
        liked = False
        if request.user.is_authenticated:
            if post.likes.filter(id=request.user.id).exists():
                liked = True
        return render(
            request,
            "post_detail.html",
            {
                "post": post,
                "liked": liked,
            },
        )

    def post(self, request, slug, *args, **kwargs):
        post = get_object_or_404(Post, slug=slug)
        if request.user.is_authenticated:
            if post.likes.filter(id=request.user.id).exists():
                post.likes.remove(request.user)
            else:
                post.likes.add(request.user)
        return HttpResponseRedirect(reverse('post_detail', args=[slug]))

