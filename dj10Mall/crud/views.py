from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Food, Coupon
from django.contrib.contenttypes.models import ContentType


# Create your views here.


class CrudView(APIView):

    def get(self, request):
        # 给面包创建一个优惠券
        food_obj = Food.objects.filter(id=1).first()
        # Coupon.objects.create(title="面包九五折", content_type_id=8, object_id=1)
        # Coupon.objects.create(title="双十一面包九折促销", content_object=food_obj)

        # 查询面包都有哪些优惠券【反向查询，不会生成表字段】
        # coupons = food_obj.coupons.all()
        # print(coupons)
        # 优惠券查对象
        # coupon_obj = Coupon.objects.filter(id=1).first()
        # content_obj = coupon_obj.content_object
        # print(coupon_obj.title)
        #
        # # 通过ContentType表找 指定表模型
        # content = ContentType.objects.filter(app_label="crud", model="food").first()
        # print(content)
        # model_class = content.model_class()
        # ret = model_class.objects.all()  # 再查找指定表的所有表数据
        # print(ret)

        return Response("ContentType测试")
