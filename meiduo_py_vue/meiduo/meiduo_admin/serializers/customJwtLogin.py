from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        # Add custom claims
        # token['name'] = user.username
        # ...

        return token

    #  登录 返回token验证
    def validate(self, attrs):
        data = super().validate(attrs)

        refresh = self.get_token(self.user)

        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)  # token
        data['username'] = self.user.username  # 这个是你的自定义返回的
        data['user_id'] = self.user.id  # 这个是你的自定义返回的

        return data
