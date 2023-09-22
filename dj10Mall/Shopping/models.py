
from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from Login.models import Account

# Create your models here.
__all__ = ["Coupon", "CouponRecord", "Order", "OrderDetail", "TransactionRecord"]


class Coupon(models.Model):
    """优惠券生成规则"""
    name = models.CharField(max_length=64, verbose_name="活动名称")
    brief = models.TextField(blank=True, null=True, verbose_name="优惠券介绍")
    # 三种优惠券能否叠加使用呢？
    coupon_type_choices = ((0, '通用券'), (1, '满减券'), (2, '折扣券'))
    coupon_type = models.SmallIntegerField(choices=coupon_type_choices, default=0, verbose_name="券类型")

    # 通用券 满减券 时，需要减掉相等的金额 【有了默认值，后面的支付接口，计算优惠券后的金额更方便操作】
    money_equivalent_value = models.IntegerField(verbose_name="等值货币", null=True, blank=True, default=0)
    # 折扣券 时，按原来的价格进行折扣计算
    off_percent = models.PositiveSmallIntegerField("折扣百分比", help_text="只针对折扣券，例7.9折，写79", blank=True, null=True, default=100)
    # 满减券 使用前需要校验一下，是否符合使用 满减劵的条件
    minimum_consume = models.PositiveIntegerField("最低消费", default=0, help_text="仅在满减券时填写此字段", null=True, blank=True)

    content_type = models.ForeignKey(ContentType, blank=True, null=True, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField("绑定课程", blank=True, null=True, help_text="可以把优惠券跟课程绑定")
    # 不绑定代表全局优惠券
    content_object = GenericForeignKey('content_type', 'object_id')

    open_date = models.DateField("优惠券领取开始时间")
    close_date = models.DateField("优惠券领取结束时间")
    valid_begin_date = models.DateField(verbose_name="有效期开始时间", blank=True, null=True)
    valid_end_date = models.DateField(verbose_name="有效结束时间", blank=True, null=True)
    coupon_valid_days = models.PositiveIntegerField(verbose_name="优惠券有效期（天）", blank=True, null=True,
                                                    help_text="自券被领时开始算起")
    # 创建此优惠券的时间
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "13. 优惠券生成规则记录"
        db_table = verbose_name_plural
        verbose_name = verbose_name_plural

    def __str__(self):
        return "%s(%s)" % (self.get_coupon_type_display(), self.name)

    # 保存当前优惠券时，需要做的一些前置处理，类似事务功能
    def save(self, *args, **kwargs):
        if not self.coupon_valid_days or (self.valid_begin_date and self.valid_end_date):
            if self.valid_begin_date and self.valid_end_date:
                if self.valid_end_date <= self.valid_begin_date:
                    raise ValueError("valid_end_date 有效期结束日期必须晚于 valid_begin_date ")
            if self.coupon_valid_days == 0:
                raise ValueError("coupon_valid_days 有效期不能为0")
        if self.close_date < self.open_date:
            raise ValueError("close_date 优惠券领取结束时间必须晚于 open_date优惠券领取开始时间 ")

        super(Coupon, self).save(*args, **kwargs)


class CouponRecord(models.Model):
    """优惠券发放、消费纪录"""
    coupon = models.ForeignKey("Coupon", on_delete=models.CASCADE)
    number = models.CharField(max_length=64, unique=True, verbose_name="用户优惠券记录的流水号")
    account = models.ForeignKey(to=Account, verbose_name="拥有者", on_delete=models.CASCADE)
    # 只有是 未使用的优惠券 才能使用
    status_choices = ((0, '未使用'), (1, '已使用'), (2, '已过期'))
    status = models.SmallIntegerField(choices=status_choices, default=0)
    get_time = models.DateTimeField(verbose_name="领取时间", help_text="用户领取时间")
    used_time = models.DateTimeField(blank=True, null=True, verbose_name="使用时间")
    # 优惠券在哪个订单中使用的 -> 一个订单下，可能有多张优惠券
    order = models.ForeignKey("Order", blank=True, null=True, verbose_name="关联订单", on_delete=models.CASCADE)  # 一个订单可以有多个优惠券

    class Meta:
        verbose_name_plural = "14. 用户优惠券领取使用记录表"
        db_table = verbose_name_plural
        verbose_name = verbose_name_plural

    def __str__(self):
        return '%s-%s-%s' % (self.account, self.number, self.status)


# 一个订单可能会支付多个商品，那么商品详情就可以拆分成另一张表
class Order(models.Model):
    """订单"""
    payment_type_choices = ((0, '微信'), (1, '支付宝'), (2, '优惠码'), (3, '贝里'))
    payment_type = models.SmallIntegerField(choices=payment_type_choices)

    payment_number = models.CharField(max_length=128, verbose_name="支付第3方订单号", null=True, blank=True)
    order_number = models.CharField(max_length=128, verbose_name="订单号", unique=True)  # 考虑到订单合并支付的问题
    account = models.ForeignKey(to=Account, on_delete=models.CASCADE)
    actual_amount = models.FloatField(verbose_name="实付金额")

    status_choices = ((0, '交易成功'), (1, '待支付'), (2, '退费申请中'), (3, '已退费'), (4, '主动取消'), (5, '超时取消'))
    status = models.SmallIntegerField(choices=status_choices, verbose_name="状态")
    date = models.DateTimeField(auto_now_add=True, verbose_name="订单生成时间")
    pay_time = models.DateTimeField(blank=True, null=True, verbose_name="付款时间")
    cancel_time = models.DateTimeField(blank=True, null=True, verbose_name="订单取消时间")

    class Meta:
        verbose_name_plural = "15. 订单表"
        db_table = verbose_name_plural
        verbose_name = verbose_name_plural

    def __str__(self):
        return "%s" % self.order_number


class OrderDetail(models.Model):
    """订单详情"""
    order = models.ForeignKey("Order", on_delete=models.CASCADE)

    # 用于反向查询
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)  # 可关联普通课程或学位
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')

    original_price = models.FloatField("课程原价")
    price = models.FloatField("折后价格")
    valid_period_display = models.CharField("有效期显示", max_length=32)  # 在订单页显示
    valid_period = models.PositiveIntegerField("有效期(days)")  # 课程有效期
    memo = models.CharField(max_length=255, blank=True, null=True, verbose_name="备忘录")

    def __str__(self):
        return "%s - %s - %s" % (self.order, self.content_type, self.price)

    class Meta:
        verbose_name_plural = "16. 订单详细"
        db_table = verbose_name_plural
        verbose_name = verbose_name_plural


# 类似于内部优惠券，消费越多，都会记录下来，以后可能有更多的优惠
class TransactionRecord(models.Model):
    """贝里交易纪录"""
    account = models.ForeignKey(to=Account, on_delete=models.CASCADE)
    amount = models.IntegerField("金额")
    balance = models.IntegerField("账户余额")
    transaction_type_choices = ((0, '收入'), (1, '支出'), (2, '退款'), (3, "提现"))  # 2 为了处理 订单过期未支付时，锁定期贝里的回退
    transaction_type = models.SmallIntegerField(choices=transaction_type_choices)
    transaction_number = models.CharField(unique=True, verbose_name="流水号", max_length=128)
    date = models.DateTimeField(auto_now_add=True)
    memo = models.CharField(max_length=128, blank=True, null=True, verbose_name="备忘录")

    class Meta:
        verbose_name_plural = "17. 贝里交易记录"
        db_table = verbose_name_plural
        verbose_name = verbose_name_plural

    def __str__(self):
        return "%s" % self.transaction_number


