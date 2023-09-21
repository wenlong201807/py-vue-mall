from rest_framework.views import APIView
from rest_framework.response import Response
from utils.base_response import BaseResponse
from utils.my_auth import LoginAuth
from utils.redis_pool import POOL
from Course.models import Course
import json
import redis

# 前端传过来 course_id  price_policy_id
# 把购物车数据放入redis  <- 存到哪？
"""
{
    SHOPPINGCAR_USERID_COURSE_ID: {
        "id", # 课程id
        "title",
        "course_img",
        "price_policy_dict": { # 具体价格策略可以独立另一个接口，前端自行处理组合。恶心的后端
            price_policy_id: "{valid_period,  price}"
            price_policy_id2: "{valid_period,  price}"
            price_policy_id3: "{valid_period,  price}"
        },
        "default_price_policy_id": 1
    }
}
"""

SHOPPINGCAR_KEY = "SHOPPINGCAR_%s_%s"
CONN = redis.Redis(connection_pool=POOL)


class ShoppingCarView(APIView):
    # 加入购物车操作前，必须是登录状态
    authentication_classes = [LoginAuth, ]

    # 加入购物车
    def post(self, request):
        res = BaseResponse()
        # 1, 获取前端传过来的数据以及user_id

        # post 参数获取方式 request.data
        course_id = request.data.get("course_id", "")
        price_policy_id = request.data.get("price_policy_id", "")
        user_id = request.user.pk  # 获取用户id django已经内置处理好的
        # 2, 校验数据的合法性
        # 2.1 校验课程id合法性
        course_obj = Course.objects.filter(id=course_id).first()
        if not course_obj:
            res.code = 1040
            res.error = "课程id不合法"
            return Response(res.dict)
        # 2.2 校验价格策略id是否合法
        # 在 Course表中，有属性 course_obj， 进行反向查询的另一张 GenericRelation关联的表
        # 【反向查询】price_policy = GenericRelation("PricePolicy")
        price_policy_queryset = course_obj.price_policy.all()  # 虽然是查询所有，但是，也只过滤出 course表 相关联的价格策略列表
        price_policy_dict = {}
        for price_policy in price_policy_queryset:
            # 获取所有与 course表相关的价格策略，是在修改的时候可以重新选择不同的价格策略
            price_policy_dict[price_policy.id] = {
                "price": price_policy.price,
                "valid_period": price_policy.valid_period,
                "valid_period_display": price_policy.get_valid_period_display(),  # 获取对应中文的操作
            }
        # print(price_policy_dict)
        if price_policy_id not in price_policy_dict:
            res.code = 1041
            res.error = "价格策略id不合法"
            return Response(res.dict)
        # 3，构建redisKEY
        key = SHOPPINGCAR_KEY % (user_id, course_id)
        # 4，构建数据结构
        course_info = {
            "id": course_obj.id,
            "title": course_obj.title,
            "course_img": str(course_obj.course_img),  # 必须是字符串
            "price_policy_dict": json.dumps(price_policy_dict, ensure_ascii=False),  # json 化，返回非二进制，前端才能使用
            "default_price_policy_id": price_policy_id
        }
        # 5  写入redis
        CONN.hmset(key, course_info)
        res.data = "加入购物车成功"
        return Response(res.dict)

    #  查看购物车列表
    def get(self, request):
        res = BaseResponse()
        # 1, 拼接redis key
        user_id = request.user.pk
        shopping_car_key = SHOPPINGCAR_KEY % (user_id, "*")  # redis 支持模糊匹配
        # 2, 去redis中读取数据
        # 2.1 匹配所有的keys
        # 3，构建数据结构展示
        all_keys = CONN.scan_iter(shopping_car_key)
        ret = []
        for key in all_keys:
            ret.append(CONN.hgetall(key))
        res.data = ret
        return Response(res.dict)

    # 修改购物车中的价格策略
    def put(self, request):
        # 前端 course_id  price_policy_id
        res = BaseResponse()
        # 1, 获取前端传过来的数据以及user_id
        course_id = request.data.get("course_id", "")
        price_policy_id = request.data.get("price_policy_id", "")
        user_id = request.user.pk
        # 2, 校验数据的合法性
        # 2.1 course_id是否合法
        key = SHOPPINGCAR_KEY % (user_id, course_id)
        if not CONN.exists(key):  # 某key 是否存在redis中
            res.code = 1043
            res.error = "课程id不合法"
            return Response(res.dict)
        # 2,2 price_policy_id是否合法
        price_policy_dict = json.loads(CONN.hget(key, "price_policy_dict"))  # 存入的时候是 json化，现在取出来使用，需要去json化
        if str(price_policy_id) not in price_policy_dict:
            res.code = 1044
            res.error = "价格策略不合法"
            return Response(res.dict)
        # 3, 更新redis  default_price_policy_id
        CONN.hset(key, "default_price_policy_id", price_policy_id)
        res.data = "更新成功"
        return Response(res.dict)

    # 删除购物车的信息
    def delete(self, request):
        # course_list = [course_id, ]
        res = BaseResponse()
        # 1 获取前端传来的数据以及user_id
        course_list = request.data.get("course_list", "")
        user_id = request.user.pk
        # 2 校验course_id是否合法【是否在redis中，即是否是某用户中的物品】
        for course_id in course_list:
            key = SHOPPINGCAR_KEY % (user_id, course_id)
            if not CONN.exists(key):
                res.code = 1045
                res.error = "课程ID不合法"
                return Response(res.dict)
            # 3， 删除redis数据
            CONN.delete(key)
        res.data = "删除成功"
        return Response(res.dict)
