from django.db import models
from datetime import date, datetime

from utils.common import user_directory_path

# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["SchoolCategory", "Clas", "ClassRoom", "Teacher", "CourseSchool", "Student", "StudentDetail"]


class SchoolCategory(models.Model):
    """院系表"""
    title = models.CharField(max_length=32, unique=True, verbose_name="学院分类")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "院系表"
        db_table = 'db_school_category'
        verbose_name_plural = verbose_name


class Clas(models.Model):
    '''
    一个班级，包含如下内容：
       班级的名字
       属于哪个院系
       班级的荣誉口号
       班级所在的教室【一个班级必须要有一个教室，一个教室只能属于一个班级】
       一个班主任【一个老师只能是一个班的班主任, 一个班只能有一个班主任】非必填
       一个班级一个课程

       # 多个课程【一个班级有多个课程里，一个课程可以在多个班级里】，
       # 多个科任老师【一个班级需要多个科任老师，一个老师可以在多个班级授课】
    '''
    name = models.CharField(max_length=32, verbose_name="班级名称")
    # Category 表 是一， Course 表是多，外键关联写在多的这里
    category = models.ForeignKey(to="SchoolCategory", verbose_name="班级所在的院系的分类", on_delete=models.CASCADE)

    honor_title = models.CharField(max_length=32, verbose_name="班级的荣誉口号")
    class_room = models.OneToOneField("ClassRoom", related_name="classRoom_clas_rel", on_delete=models.CASCADE,
                                      null=False)
    class_teacher = models.OneToOneField("Teacher", related_name="class_teacher_clas_rel", on_delete=models.CASCADE,
                                         null=False)

    clas_course = models.OneToOneField("CourseSchool", related_name="clas_course_rel", on_delete=models.CASCADE,
                                       null=False)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "班级表"
        db_table = "db_class"
        verbose_name_plural = verbose_name


class ClassRoom(models.Model):
    '''
    教室表
       教室的名字
       教室的地址
       教室的大小[可以容纳人数]
       是否是多媒体教室
    '''
    name = models.CharField(max_length=32, verbose_name="教室名称")
    room_addr = models.CharField(max_length=32, verbose_name="教室地址")
    capacity_num = models.SmallIntegerField(verbose_name="可以容纳人数")
    isMedia_room = models.BooleanField(default=False, verbose_name="是否是多媒体教室")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "教室表"
        db_table = "db_class_room"
        verbose_name_plural = verbose_name


class Teacher(models.Model):
    '''
    教师表，包含
       老师的名字
       老师的性别
       老师的手机号
       老师的头像
       老师的简介

    '''
    name = models.CharField(max_length=32, verbose_name="老师名字")
    section_type_choices = ((0, '男'), (1, '女'), (2, '保密'))
    sex = models.SmallIntegerField(default=2, choices=section_type_choices, verbose_name="老师性别")
    mobile = models.CharField(max_length=12, verbose_name="老师的手机号")
    avatar = models.ImageField(upload_to=user_directory_path, default="/avatar/default.png")
    brief = models.TextField(max_length=1024, verbose_name="讲师介绍")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "教师表"
        db_table = "db_teacher"  # 表名字，暂时使用中文，后续需改为英文
        verbose_name_plural = verbose_name


class CourseSchool(models.Model):
    '''
    课程表 学校的
       课程名字
       课程学习后所得积分
       课程的执教老师【如果课程没有执教老师，则不能开课】
       上课时间
       是否是选修课，必修课，默认必修课
       星期几上课，可多选
       下课时间 # 一节课固定40分钟
       上课的教室【一个教室可以有多个课程，一个课程可以在多个教室 教授】【多对多】
    '''
    title = models.CharField(max_length=32, verbose_name="课程名称")
    credit = models.IntegerField(verbose_name="学分", default=3)

    must_choices = ((1, '选修课'), (2, '必修课'))
    course_stay_time = models.SmallIntegerField(default=2, choices=must_choices, verbose_name="选修与必修")

    # week_choices = ((1, '星期一'), (2, '星期二'), (3, '星期三'), (4, '星期四'), (5, '星期五'))
    course_week = models.CharField(default='1', max_length=32, verbose_name="星期几上课,可多选，逗号隔开")
    course_start_time = models.TimeField(auto_now_add=True, verbose_name="开始上课时间")
    stay_choices = ((40, '40分钟'), (50, '50分钟'), (60, '60分钟'), (90, '90分钟'))
    course_stay_time = models.SmallIntegerField(default=40, choices=stay_choices, verbose_name="课程时长")
    course_room = models.ManyToManyField("ClassRoom",
                                         related_name="course_room_rel",
                                         db_table="db_course2room")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "课程"
        db_table = "db_course_school"
        verbose_name_plural = verbose_name


class Student(models.Model):
    '''
    学生表
       姓名
       手机号

       哪个班的学生【一个学生只能在一个班级学习，一个班级可以有多个学生】
       选了哪些选修课程【至少选两门课程】【上课时间是否冲突】【后期备用，选修课使用的】
       学生的其他个人信息【查看详情表】【默认保密，有查看权限，分到另外一张表存储】
    '''

    name = models.CharField(max_length=32, unique=True, verbose_name="姓名")
    mobile = models.CharField(max_length=12, verbose_name="学生的手机号")

    # 一对一的关系：建立关联字段,在数据库中生成关联字段：stu_detail_id
    stu_detail = models.OneToOneField("StudentDetail", related_name="stu", on_delete=models.CASCADE, null=True)
    electives_course = models.ManyToManyField("CourseSchool",
                                              verbose_name="只能选择选修课程",
                                              related_name="electives_course_rel",
                                              db_table="db_electives2clas")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "学生表"
        db_table = "db_student"  # 表名字，暂时使用中文，后续需改为英文
        verbose_name_plural = verbose_name


class StudentDetail(models.Model):
    '''
    学生详情表
       头像
       家庭地址
       生日
       年龄
       父亲名字
       母亲名字
       性别

    '''
    nickname = models.CharField(max_length=32, verbose_name="昵称")
    avatar = models.ImageField(upload_to=user_directory_path, default='/avatar/default.png', null=True, blank=True,
                               verbose_name='默认图片')
    family_addr = models.CharField(max_length=32)
    birthday = models.DateTimeField(default=datetime.now())
    father_name = models.CharField(max_length=32, verbose_name="父亲名字", default='保密')
    mother_name = models.CharField(max_length=32, verbose_name="母亲名字", default='保密')

    sex_choices = (
        (0, "女"),
        (1, "男"),
        (2, "保密"),
    )
    sex = models.SmallIntegerField(choices=sex_choices)

    def __str__(self):
        return self.nickname

    class Meta:
        verbose_name = "学生详情表"
        db_table = "db_stu_detail"
        verbose_name_plural = verbose_name
