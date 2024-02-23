from django.contrib import admin
from .models import Post
from django_summernote.admin import SummernoteModelAdmin

@admin.register(Post)

class PostAdmin(SummernoteModelAdmin):
   
    list_display = ('title', 'date_published', 'status')
    list_filter = ('status', 'date_published')
    search_fields = ('title', 'content')
    summernote_fields = ('content',)

