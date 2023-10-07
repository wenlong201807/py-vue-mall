from django.urls import re_path as url, path

from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    # TokenRefreshView,
)
from meiduo_admin.views.usersView import MyTokenObtainPairView

urlpatterns = [
    # 后台系统的 登录 参考 https://www.jianshu.com/p/7ebf659c57a3
    # url(r'^authorizations/$', obtain_jwt_token),  # 内部对 用户名和密码做了校验
    path('authorizations/', MyTokenObtainPairView.as_view(), name='token_obtain_pair_cus'),
    # path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    # path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
