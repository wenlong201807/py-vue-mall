"""dj10Mall URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/dev/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.views.static import serve
from dj10Mall import settings
from Login.views import GeetestView

from testApp.views import DemoView
from crud.views import CrudView

urlpatterns = [
    path('admin/', admin.site.urls),

    path('demo/', DemoView.as_view()),
    path('crud/', CrudView.as_view()),

    path('api/course/', include("Course.urls")),
    path('api/shop/', include("Shopping.urls")),
    path('api/', include("Login.urls")),
    path('pc-geetest/register', GeetestView.as_view()),
    path('pc-geetest/ajax_validate', GeetestView.as_view()),

    path('api/student/', include("Student.urls")),
    path('api/user/', include("UserInfo.urls")),

    # media路径配置
    # 1.1版 path('media/(?P<path>.*)', serve, {'document_root': settings.MEDIA_ROOT})
    # 2.x版本的配置路径方式
    re_path('media/(?P<path>.*)', serve, {'document_root': settings.MEDIA_ROOT})

]
