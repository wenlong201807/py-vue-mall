from django.db import models
from django.contrib.auth.models import AbstractUser

from Student.models import Student

from utils.common import user_directory_path

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["UserInfo"]


class UserInfo(AbstractUser):
    # avatar = models.ImageField(upload_to=user_directory_path, null=True)
    avatar = models.ImageField(upload_to=user_directory_path, default="/avatar/default.png")
    stu = models.OneToOneField(Student, on_delete=models.CASCADE, null=True)
