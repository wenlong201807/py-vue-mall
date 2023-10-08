from django.urls import re_path as url, path
from meiduo_admin.views.usersView import MyTokenObtainPairView
from rest_framework.routers import DefaultRouter
from meiduo_admin.home import home_views
from meiduo_admin.user import user_views
from meiduo_admin.views import specs, options
from meiduo_admin.views import skus, spus
from meiduo_admin.views import permissions, group, admin
from meiduo_admin.views import brand

from meiduo_admin.views import orders

# from meiduo_admin.views import images

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

    # 用户管理
    url(r'^users/$', user_views.UserView.as_view()),

    # ------------规格路由表-----------两种方式都可以实现
    url(r'^goods/simple/$', specs.SpecsView.as_view({'get': 'simple'})),
    url(r'^goods/specs/simple/$', options.OptionSimple.as_view()),

    # ------------图片路由————————————
    #     url(r'^skus/simple/$', images.ImagesView.as_view({'get': 'simple'})),

    # ------------sku路由————————————
    # 在 SKUVIew 视图集内 定义的方法 specs 请求方法 get
    url(r'^goods/(?P<pk>\d+)/specs/$', skus.SKUVIew.as_view({'get': 'specs'})),
    url(r'^goods/brands/simple/$', spus.SPUGoodsView.as_view({'get': 'brand'})),
    url(r'^goods/channel/categories/$', spus.SPUGoodsView.as_view({'get': 'channel'})),
    url(r'^goods/channel/categories/(?P<pk>\d+)/$', spus.SPUGoodsView.as_view({'get': 'channels'})),

    # --------权限路由--------
    url(r'^permission/content_types/$', permissions.PermissionsView.as_view({'get': 'content_type'})),
    # --------分组路由--------
    url(r'^permission/simple/$', group.GroupView.as_view({'get': 'simple'})),
    # --------管理员路由--------
    url(r'^permission/groups/simple/$', admin.AdminView.as_view({'get': 'simple'})),

]

# ----------规格表路由------
router = DefaultRouter()
router.register('goods/specs', specs.SpecsView, basename='specs')
urlpatterns += router.urls

# -------图片表路由------
# router = DefaultRouter()
# router.register('skus/images', images.ImagesView, basename='images')
# urlpatterns += router.urls

# 1, skus 对应页面位置: 左侧菜单 -> 商品管理 -> sku管理
router = DefaultRouter()
router.register("skus", skus.SKUVIew, basename="skus")
urlpatterns += router.urls

# --------spus路由--------
router = DefaultRouter()
router.register('goods', spus.SPUGoodsView, basename='spus')
urlpatterns += router.urls

# ----------品牌管理 路由------[路由命名时，有优先级，不完全匹配规则，因此，不能有交叉]
router = DefaultRouter()
router.register('brands', brand.BrandView, basename='brands')
urlpatterns += router.urls


# --------商品管理-规格选项管理 路由--------
router = DefaultRouter()
router.register('specs/options', options.OptionsView, basename='options')
urlpatterns += router.urls

# --------订单路由--------[有问题，缺少tb_order_goods表]
router = DefaultRouter()
router.register('orders', orders.OrderView, basename='orders')
urlpatterns += router.urls

# --------权限路由--------
router = DefaultRouter()
router.register('permission/perms', permissions.PermissionsView, basename='perms')
urlpatterns += router.urls

# --------分组路由--------
router = DefaultRouter()
router.register('permission/groups', group.GroupView, basename='groups')
urlpatterns += router.urls

# --------管理员路由--------
router = DefaultRouter()
router.register('permission/admins', admin.AdminView, basename='admin')
urlpatterns += router.urls
