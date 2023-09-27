from django.db import models
from django.contrib.auth.models import AbstractUser

from Student.models import Student, Teacher

from utils.common import user_directory_path

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["UserInfo"]


class UserInfo(AbstractUser):
    # avatar = models.ImageField(upload_to=user_directory_path, null=True)
    avatar = models.ImageField(upload_to=user_directory_path, default="/avatar/default.png")
    tea = models.OneToOneField(Teacher, on_delete=models.CASCADE, null=True)
    stu = models.OneToOneField(Student, on_delete=models.CASCADE, null=True)
    role_choices = ((1, '学生'), (2, '老师'), (3, '校长'), (4, '院长'))
    role_type = models.SmallIntegerField(default=1, choices=role_choices, verbose_name="用户的角色类型")
