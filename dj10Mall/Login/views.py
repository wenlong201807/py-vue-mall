
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import RegisterSerializer
from utils.base_response import BaseResponse
from .models import Account
from utils.redis_pool import POOL
import redis
import uuid
from utils.my_auth import LoginAuth
from utils.geetest import GeetestLib
from django.http import HttpResponse
import json
import hashlib


class RegisterView(APIView):

    def post(self, request):
        res = BaseResponse()
        # 用序列化器做校验
        ser_obj = RegisterSerializer(data=request.data)
        if ser_obj.is_valid():
            ser_obj.save()  # 保存到数据库
            res.data = ser_obj.data
        else:  # 没通过校验，返回错误消息
            res.code = 1020
            res.error = ser_obj.errors
        return Response(res.dict)


class LoginView(APIView):
    def post(self, request):
        res = BaseResponse()
        username = request.data.get("username", "")
        pwd = request.data.get("pwd", "")

        # 需继续完善功能，不可重复登录【前端处理】
        # 密码加盐处理，与注册时一致
        pwd_salt = "wen_password" + pwd  # 加密的盐值
        md5_num = hashlib.md5(pwd_salt.encode()).hexdigest()
        md5_str = str(md5_num)

        user_obj = Account.objects.filter(username=username, pwd=md5_str).first()
        if not user_obj:
            res.code = 1030
            res.error = "用户名或密码错误"
            return Response(res.dict)
        # 用户登录成功生成一个token写入redis
        # 写入redis  token : user_id 【Account 表中的id】
        conn = redis.Redis(connection_pool=POOL)
        try:
            token = uuid.uuid4()  # 生成一个随机字符
            conn.set(str(token), user_obj.id)  # 存入到redis中
            # conn.set(str(token), user_obj.id, ex=10)  # 存入到redis中 并且设置过期时间
            res.token = token
        except Exception as e:
            print(e)
            res.code = 1031
            res.error = "创建令牌失败"
        return Response(res.dict)


class TestView(APIView):
    # 进入这个试图，都需要经过认证 如果不通过，则不执行后续代码
    authentication_classes = [LoginAuth, ]

    def get(self, request):
        return Response("认证测试")


pc_geetest_id = "b46d1900d0a894591916ea94ea91bd2c"
pc_geetest_key = "36fc3fe98530eea08dfc6ce76e3d24c4"
REDIS_CONN = redis.Redis(connection_pool=POOL)


class GeetestView(APIView):

    def get(self, request):
        user_id = 'test'
        gt = GeetestLib(pc_geetest_id, pc_geetest_key)
        status = gt.pre_process(user_id)
        # request.session[gt.GT_STATUS_SESSION_KEY] = status
        REDIS_CONN.set(gt.GT_STATUS_SESSION_KEY, status)
        # request.session["user_id"] = user_id
        REDIS_CONN.set("gt_user_id", user_id)
        response_str = gt.get_response_str()
        return HttpResponse(response_str)

    def post(self, request):
        # print(request.session.get("user_id"))
        print(request.META.get("HTTP_AUTHENTICATION"))
        print(request.data)
        gt = GeetestLib(pc_geetest_id, pc_geetest_key)
        challenge = request.data.get(gt.FN_CHALLENGE, '')
        validate = request.data.get(gt.FN_VALIDATE, '')
        seccode = request.data.get(gt.FN_SECCODE, '')
        # username
        # pwd
        # status = request.session.get(gt.GT_STATUS_SESSION_KEY)
        # print(status)
        # user_id = request.session.get("user_id")
        # print(user_id)
        status = REDIS_CONN.get(gt.GT_STATUS_SESSION_KEY)
        user_id = REDIS_CONN.get("gt_user_id")
        if status:
            result = gt.success_validate(challenge, validate, seccode, user_id)
        else:
            result = gt.failback_validate(challenge, validate, seccode)
        result = {"status": "success"} if result else {"status": "fail"}
        # if result:
        #     # 证明验证码通过
        #     # 判断用户名和密码
        # else:
        #     #  返回验证码错误
        return HttpResponse(json.dumps(result))





