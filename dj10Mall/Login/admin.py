from django.contrib import admin

from . import models

# 反射机制的应用
for table in models.__all__:
    admin.site.register(getattr(models, table))