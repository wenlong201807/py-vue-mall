
from rest_framework.views import APIView
from rest_framework.response import Response
from utils.base_response import BaseResponse
from django.contrib import auth
from django.middleware.csrf import get_token
from . import models
# from .serializers import CategorySerializer, CourseSerializer, CourseDetailSerializer, CourseChapterSerializer
# from .serializers import CourseCommentSerializer, QuestionSerializer

# Create your views here.


class UserinfoView(APIView):

    def post(self, request):
        res = BaseResponse()
        # print(request.data)
        user = request.POST.get("username")
        pwd = request.POST.get("password")

        # 使用了用户认证组件
        user = auth.authenticate(username=user, password=pwd)
        # print('user:', user)  # 失败，为啥呢？
        if user:
            # 验证成功
            # 写session: request.session["user_id"] =user.id
            auth.login(request, user)
            token = get_token(request)  # 前后端分离，避免csrf攻击
            # print('token:', token)
            res.data = token
            return Response(res.dict)

        # res.code = 1001  # 登录失败
        return Response(res.dict)

    def delete(self, request):
        # course_list = [course_id, ]
        res = BaseResponse()
        auth.logout(request)
        res.data = "退出成功"
        return Response(res.dict)
    # def get(self, request):
    #     # 通过ORM操作获取所有分类数据
    #     queryset = models.Category.objects.all()
    #     # 利用序列化器去序列化我们的数据
    #     # ser_obj = CategorySerializer(queryset, many=True)  # 返回多条数据时，加上many=True
    #     # 返回
    #     return Response({"state": 'ok'})
