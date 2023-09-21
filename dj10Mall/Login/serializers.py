
from rest_framework import serializers
from .models import Account
import hashlib


class RegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model = Account
        fields = "__all__"

    def create(self, validated_data):
        pwd = validated_data["pwd"]  # 校验通过的密码
        pwd_salt = "wen_password" + pwd  # 加密的盐值
        md5_str = hashlib.md5(pwd_salt.encode()).hexdigest()
        user_obj = Account.objects.create(username=validated_data["username"], pwd=md5_str)
        return user_obj