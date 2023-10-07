from django.urls import re_path as url, path
from meiduo_admin.views.usersView import MyTokenObtainPairView
from meiduo_admin.home import home_views

urlpatterns = [
    # 后台系统的 登录 参考 https://www.jianshu.com/p/7ebf659c57a3
    path('authorizations/', MyTokenObtainPairView.as_view(), name='token_obtain_pair_cus'),  # 内部对 用户名和密码做了校验
    # path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    # path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # 首页
    url(r'^statistical/total_count/$', home_views.UserTotalCountView.as_view()),
    url(r'^statistical/day_active/$', home_views.UserDayActiveView.as_view()),
    url(r'^statistical/day_increment/$', home_views.UserDayIncrementView.as_view()),
    url(r'^statistical/day_orders/$', home_views.UserDayOrdersView.as_view()),
    url(r'^statistical/month_increment/$', home_views.UserMonthIncrementView.as_view()),
    url(r'^statistical/goods_day_views/$', home_views.GoodCategoryDayView.as_view()),
]
