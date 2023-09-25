from django.db import models
from Student.models import Student

from django.contrib.auth.models import AbstractUser
import os

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["UserInfo"]


def user_directory_path(instance, filename):
    return os.path.join(instance.username, "avatars", filename)


class UserInfo(AbstractUser):
    # avatar = models.ImageField(upload_to=user_directory_path, null=True)
    avatar = models.ImageField(upload_to=user_directory_path, default="/avatar/default.png")
    stu = models.OneToOneField(Student, on_delete=models.CASCADE, null=True)
