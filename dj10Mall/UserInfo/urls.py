

from django.urls import path
from .views import UserinfoView

urlpatterns = [
    path('loginOrout', UserinfoView.as_view()),


]