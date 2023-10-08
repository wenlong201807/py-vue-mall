
from rest_framework.viewsets import ModelViewSet
from goods.models import Brand
from meiduo_admin.serializers.brand import BrandSerializer
from utils.my_pagination import MyPageNumberPagination


class BrandView(ModelViewSet):
    """
        品牌表的增删改查
    """
    print(666)
    serializer_class = BrandSerializer
    queryset = Brand.objects.all()
    pagination_class = MyPageNumberPagination