from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        print(88, user.username, user.id)
        print(99, token , type(token))
        # print(77, token.refresh)
        # print(66, token.access)

        # Add custom claims
        # token['name'] = 888
        # ...
        return token
        # return {
        #     "token": token,
        #     "username": user.username,
        #     "id": user.id
        # }

    '''
        token验证
        '''

    def validate(self, attrs):
        data = super().validate(attrs)

        refresh = self.get_token(self.user)

        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)
        data['username'] = self.user.username  # 这个是你的自定义返回的
        data['user_id'] = self.user.id  # 这个是你的自定义返回的

        return data