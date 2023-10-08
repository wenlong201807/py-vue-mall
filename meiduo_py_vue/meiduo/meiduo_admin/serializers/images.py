# from django.conf import settings
from meiduo import settings
# from fdfs_client.client import Fdfs_client
# from requests import Response
from rest_framework.response import Response
from rest_framework import serializers
from goods.models import SKUImage, SKU


# from celery_tasks.static_file.tasks import get_detail_html


class ImagesSerializer(serializers.ModelSerializer):
    """
        图片序列化器
    """
    # read_only=True 只读取，不写入
    sku_id = serializers.IntegerField(read_only=True)  # 外键关联的表字段是这个，可直接使用序列化器

    image = serializers.SerializerMethodField()

    # 参数obj 是 models.py 中 对应class【Brand】中定义的属性名【logo】
    def get_image(self, obj):
        return settings.FE_MEDIA_DOMAIN + str(obj.image)

    class Meta:
        model = SKUImage
        fields = "__all__"

    def create_bad(self, validated_data):
        # 3、建立fastdfs的客户端
        client = ''
        # client = Fdfs_client(settings.FASTDFS_PATH)

        # self.context['request'] 获取request对象

        file = self.context['request'].FILES.get('image')
        # 4、上传图片
        res = client.upload_by_buffer(file.read())
        # 5、判断是否上传成功
        if res['Status'] != 'Upload successed.':
            raise serializers.ValidationError({'error': '图片上传失败'})

        # 6、保存图片表
        img = SKUImage.objects.create(sku=validated_data['sku'], image=res['Remote file_id'])

        # 异步生成详情页静态页面
        # get_detail_html.delay(img.sku.id)

        return img

    def update_bad(self, instance, validated_data):
        # 3、建立fastdfs的客户端
        client = ''
        # client = Fdfs_client(settings.FASTDFS_PATH)

        # self.context['request'] 获取request对象

        file = self.context['request'].FILES.get('image')
        # 4、上传图片
        res = client.upload_by_buffer(file.read())
        # 5、判断是否上传成功
        if res['Status'] != 'Upload successed.':
            raise serializers.ValidationError({'error': '图片上传失败'})

        # 6、更新图片表
        instance.image = res['Remote file_id']
        instance.save()

        # 异步生成详情页静态页面
        # get_detail_html.delay(instance.sku.id)
        return instance


class SKUSerializer(serializers.ModelSerializer):
    """
        sku序列化器
    """

    class Meta:
        model = SKU
        fields = ('id', 'name')
