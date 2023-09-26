from django.contrib import admin
from django.urls import path, include, re_path

from Student.views import  add_student, delete_student,edit_student,elective,search,stu_excel
from Student.views import ClssView, CourseView

urlpatterns = [
    path('clsslist', ClssView.as_view()),
    path('courselist', CourseView.as_view()),

    path("add/", add_student),
    re_path("delete/(\d+)", delete_student),
    re_path("edit/(\d+)", edit_student),
    # 选课
    re_path("elective/", elective),
    # 筛选
    path("search/",search),

    # 通过excel表格批量导入数据
    path("stu_excel/",stu_excel)

]
