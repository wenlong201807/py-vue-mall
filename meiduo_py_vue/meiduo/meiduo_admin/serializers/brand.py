from meiduo import settings
from rest_framework import serializers
from goods.models import Brand


class BrandSerializer(serializers.ModelSerializer):
    """
            品牌序列化器
    """
    logo = serializers.SerializerMethodField()

    # 参数obj 是 models.py 中 对应class【Brand】中定义的属性名【logo】
    def get_logo(self, obj):
        print(99, obj.logo, settings.FE_MEDIA_DOMAIN)
        return settings.FE_MEDIA_DOMAIN + str(obj.logo)


    class Meta:
        model = Brand
        fields = '__all__'
