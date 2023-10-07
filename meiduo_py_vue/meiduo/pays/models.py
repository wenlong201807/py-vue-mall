from django.db import models
from utils.my_model import BaseModel

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["Payment"]


# 1,支付结果模型类
class Payment(BaseModel):
    out_trade_no = models.CharField(verbose_name='美多商城编号', max_length=64, unique=True, null=False)
    trade_no = models.CharField(verbose_name="支付宝流水号", max_length=64, unique=True, null=False)

    class Meta:
        db_table = "tb_payment"
