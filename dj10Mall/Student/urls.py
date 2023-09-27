from django.urls import path, re_path

from Student.views.teacherView import add_student, delete_student, edit_student, elective, search, stu_excel
from Student.views.teacherView import ClssView, ClssAddExcel, CourseView
from Student.views.schoolBaseView import SchoolTeacherView, SchoolBachExcel, \
    SchoolStudentDetailView, SchoolStudentView, SchoolClassRoomView

urlpatterns = [
    path('clsslist', ClssView.as_view()),
    path('batchAddClss', ClssAddExcel.as_view()),
    path('courselist', CourseView.as_view()),

    # 仅学校基本表格
    path('schoolTeacherlist', SchoolTeacherView.as_view()),
    path('schoolStuDetaillist', SchoolStudentDetailView.as_view()),
    path('schoolStudentlist', SchoolStudentView.as_view()),
    path('schoolClassRoomlist', SchoolClassRoomView.as_view()),
    # path('schoolBatchAdd?category=1', SchoolBachExcel.as_view()),
    path('schoolBatchAdd', SchoolBachExcel.as_view()),

    path("add/", add_student),
    re_path("delete/(\d+)", delete_student),
    re_path("edit/(\d+)", edit_student),
    # 选课
    re_path("elective/", elective),
    # 筛选
    path("search/", search),

    # 通过excel表格批量导入数据
    path("stu_excel/", stu_excel)

]
