from django.db import models

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["Area"]


# 1,区域模型类
class Area(models.Model):
    name = models.CharField(verbose_name="区域", max_length=20)
    # SET_NULL: 主表删除的时候, 副表将该字段设置为空
    parent = models.ForeignKey('self', on_delete=models.SET_NULL, verbose_name="父类区域", null=True, blank=True)

    class Meta:
        db_table = "tb_areas"

    # 打印Area对象的时候,为了方便看的清除,重写__str__方法
    def __str__(self):
        return self.name
