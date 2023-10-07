from django.db import models
from utils.my_model import BaseModel
from users.models import User, Address
from goods.models import SKU

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["OrderInfo", "OrderGoods"]


class OrderInfo(BaseModel):  # 主表
    """订单信息"""
    PAY_METHODS_ENUM = {
        "CASH": 1,
        "ALIPAY": 2
    }
    PAY_METHOD_CHOICES = (
        (1, "货到付款"),
        (2, "支付宝"),
    )
    ORDER_STATUS_ENUM = {
        "UNPAID": 1,
        "UNSEND": 2,
        "UNRECEIVED": 3,
        "UNCOMMENT": 4,
        "FINISHED": 5,
        "CANCEL": 6,
    }
    ORDER_STATUS_CHOICES = (
        (1, "待支付"),
        (2, "待发货"),
        (3, "待收货"),
        (4, "待评价"),
        (5, "已完成"),
        (6, "已取消"),
    )
    order_id = models.CharField(max_length=64, primary_key=True, verbose_name="订单号")
    """
        # 外健关联的关系: 一个用户可以下多个订单，一个订单只能属于一个用户
        # user.orderInfo_set.all() 可以获取用户的所有订单，
        # User.objects.filter(orderinfo_address) [address 是orderinfo 表内的任意字段以及 OrderInfo 继承的父级 BaseModel 对应表内的字段]
        外健关联时 添加属性 related_name="haha" 那么在调用的时候，OrderInfo === haha 等效 
        即: haha__address === orderinfo__address
    """
    user = models.ForeignKey(User, on_delete=models.PROTECT, verbose_name="下单用户")
    # user = models.ForeignKey(User, related_name="haha" on_delete=models.PROTECT, verbose_name="下单用户")
    address = models.ForeignKey(Address, on_delete=models.PROTECT, verbose_name="收货地址")
    total_count = models.IntegerField(default=1, verbose_name="商品总数")
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="商品总金额")
    freight = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="运费")
    pay_method = models.SmallIntegerField(choices=PAY_METHOD_CHOICES, default=1, verbose_name="支付方式")
    status = models.SmallIntegerField(choices=ORDER_STATUS_CHOICES, default=1, verbose_name="订单状态")

    class Meta:
        db_table = "tb_order_info"
        verbose_name = '订单基本信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.order_id


class OrderGoods(BaseModel):
    """订单商品"""
    SCORE_CHOICES = (
        (0, '0分'),
        (1, '20分'),
        (2, '40分'),
        (3, '60分'),
        (4, '80分'),
        (5, '100分'),
    )
    # 副表
    order = models.ForeignKey(OrderInfo, related_name='skus', on_delete=models.CASCADE, verbose_name="订单")
    sku = models.ForeignKey(SKU, on_delete=models.PROTECT, verbose_name="订单商品")
    count = models.IntegerField(default=1, verbose_name="数量")
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="单价")
    comment = models.TextField(default="", verbose_name="评价信息")
    score = models.SmallIntegerField(choices=SCORE_CHOICES, default=5, verbose_name='满意度评分')
    is_anonymous = models.BooleanField(default=False, verbose_name='是否匿名评价')
    is_commented = models.BooleanField(default=False, verbose_name='是否评价了')

    class Meta:
        db_table = "tb_order_goods"
        verbose_name = '订单商品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.sku.name
