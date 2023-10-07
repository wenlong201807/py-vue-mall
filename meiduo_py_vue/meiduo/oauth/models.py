from django.db import models
from utils.my_model import BaseModel
from users.models import User

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["QQUserModel"]


# 1, 建立模型类, 绑定美多商城用户, 和qq之前的关系
class QQUserModel(BaseModel):
    # 关联美多用户, CASCADE级联删除(当删除美多用户的时候,将该条数据也删除)
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="美多商城用户")
    openid = models.CharField(max_length=64, verbose_name="qq用户的id")

    class Meta:
        db_table = "tb_qq_user"  # oauth 登录模式
        verbose_name = 'QQ登录用户数据'
        verbose_name_plural = verbose_name
