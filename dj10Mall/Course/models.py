from django.db import models
# Create your models here.

from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation
from django.contrib.contenttypes.models import ContentType


# 方便admin.py 中导入表格，默认的后台管理系统，录入数据使用
__all__ = ["Category", "Course", "CourseDetail", "Teacher", "DegreeCourse", "CourseChapter",
           "CourseSection", "PricePolicy", "OftenAskedQuestion", "Comment", "Account", "CourseOutline"]


class Category(models.Model):
    """课程分类表"""
    title = models.CharField(max_length=32, unique=True, verbose_name="课程的分类")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "01-课程分类表"
        db_table = verbose_name  # 表名字，暂时使用中文，后续需改为英文
        verbose_name_plural = verbose_name


class Course(models.Model):
    """课程表"""
    title = models.CharField(max_length=128, unique=True, verbose_name="课程的名称")
    course_img = models.ImageField(upload_to="course/%Y-%m", verbose_name='课程的图片')
    # Category 表 是一， Course 表是多，外键关联写在多的这里
    category = models.ForeignKey(to="Category", verbose_name="课程的分类", on_delete=models.CASCADE)

    COURSE_TYPE_CHOICES = ((0, "付费"), (1, "vip专享"), (2, "学位课程"))
    # 具体的一个课程，可能以后会属于不同的上层分类中，此处先设置一个字段做标记其父分类是哪个
    course_type = models.SmallIntegerField(choices=COURSE_TYPE_CHOICES)
    # 如果当前课程是属于 学位课程 分类中的一个课程，那么这个课程就会有对应的一个 学位等级 的课程位置，这里也需要用一个字段标记下来
    degree_course = models.ForeignKey(to="DegreeCourse", blank=True, null=True,
                                      help_text="如果是学位课程，必须关联学位表", on_delete=models.CASCADE)

    brief = models.CharField(verbose_name="课程简介", max_length=1024)
    level_choices = ((0, '初级'), (1, '中级'), (2, '高级'))
    level = models.SmallIntegerField(choices=level_choices, default=1)

    # 后台管理中，配置一个课程的状态可以使用到
    status_choices = ((0, '上线'), (1, '下线'), (2, '预上线'))
    status = models.SmallIntegerField(choices=status_choices, default=0)
    pub_date = models.DateField(verbose_name="发布日期", blank=True, null=True)

    order = models.IntegerField("课程顺序", help_text="从上一个课程数字往后排")
    # 从页面访问量来看，列表页属于高频访问页面，要展示每一门课程的学习人数，尽量不要再跨表查询这个字段，就放在这张表，更方便
    # 从表字段设计，降低【更多的】表的查询
    study_num = models.IntegerField(verbose_name="学习人数",
                                    help_text="只要有人买课程，订单表加入数据的同时给这个字段+1")

    # order_details = GenericRelation("OrderDetail", related_query_name="course")
    # coupon = GenericRelation("Coupon")
    # 只用于反向查询不生成字段【***高技能手段***】
    price_policy = GenericRelation("PricePolicy")
    often_ask_questions = GenericRelation("OftenAskedQuestion")
    course_comments = GenericRelation("Comment")

    # 模型设计中的 内置校验扩展方法
    # 因为每一个课程添加进来的时候，有必要先记录是否当前课程是学位课程分类的一个具体课，因此，当新增一个课程的时候，需要先做校验
    # 如果是学位课程 ，那么 必须要有对应的学位课程等级字段
    def save(self, *args, **kwargs):
        if self.course_type == 2:
            if not self.degree_course:
                raise ValueError("学位课必须关联学位课程表")
        super(Course, self).save(*args, **kwargs)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "02-课程表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class CourseDetail(models.Model):
    """
       课程详细表
           * 与课程表是一对一的关系： 外键关联时，可以写在任何一个表中
       拆出来这张表的目的： 课程表页面对应课程列表页，访问量大，因此接口查询应尽量快速，
       要达到此目的，后端应尽可能快的返回数据，拆表是降低课程表数据量的一个很好的解决方案
    """
    # course 添加关系类型的作用，不在CourseDetail表中展示course字段
    course = models.OneToOneField(to="Course", on_delete=models.CASCADE)

    hours = models.IntegerField(verbose_name="课时", default=7)
    course_slogan = models.CharField(max_length=125, blank=True, null=True, verbose_name="课程口号")
    video_brief_link = models.CharField(max_length=255, blank=True, null=True)
    summary = models.TextField(max_length=2048, verbose_name="课程概述")
    why_study = models.TextField(verbose_name="为什么学习这门课程")
    what_to_study_brief = models.TextField(verbose_name="我将学到哪些内容")
    career_improvement = models.TextField(verbose_name="此项目如何有助于我的职业生涯")
    prerequisite = models.TextField(verbose_name="课程先修要求", max_length=1024)

    # 与另外两张表，都是多对多的关系
    recommend_courses = models.ManyToManyField("Course", related_name="recommend_by", blank=True)
    teachers = models.ManyToManyField("Teacher", verbose_name="课程讲师")

    def __str__(self):
        return self.course.title

    class Meta:
        verbose_name = "03-课程详细表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class Teacher(models.Model):
    """讲师表"""
    name = models.CharField(max_length=32, verbose_name="讲师名字")
    brief = models.TextField(max_length=1024, verbose_name="讲师介绍")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "04-教师表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class DegreeCourse(models.Model):
    """
    字段大体跟课程表相同，哪些不同根据业务逻辑去区分
    """
    title = models.CharField(max_length=32, verbose_name="学位课程名字")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "05-学位课程表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class CourseChapter(models.Model):
    """课程章节表"""
    # 一对多： 一个课程中，会有多个章节【章节表是 多， 故 外键写在这里】
    course = models.ForeignKey(to="Course", related_name="course_chapters", on_delete=models.CASCADE)
    chapter = models.SmallIntegerField(default=1, verbose_name="第几章")
    title = models.CharField(max_length=32, verbose_name="课程章节名称")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "06-课程章节表"
        db_table = verbose_name
        verbose_name_plural = verbose_name
        unique_together = ("course", "chapter")  # 课程和课程，章节和章节都是唯一的，？？


class CourseSection(models.Model):
    """课时表【具体某一堂课】"""
    chapter = models.ForeignKey(to="CourseChapter", related_name="course_sections", on_delete=models.CASCADE)
    title = models.CharField(max_length=32, verbose_name="课时")
    section_order = models.SmallIntegerField(verbose_name="课时排序",
                                             help_text="建议每个课时之间空1至2个值，以备后续插入课时")
    section_type_choices = ((0, '文档'), (1, '练习'), (2, '视频'))
    free_trail = models.BooleanField("是否可试看", default=False)
    section_type = models.SmallIntegerField(default=2, choices=section_type_choices)
    section_link = models.CharField(max_length=255, blank=True, null=True, help_text="若是video，填vid,若是文档，填link")

    # 自定义两个方法，当需要获取对应字段时，调用函数即可
    def course_chapter(self):
        return self.chapter.chapter

    def course_name(self):
        return self.chapter.course.title

    def __str__(self):
        return "%s-%s" % (self.chapter, self.title)

    class Meta:
        verbose_name = "07-课程课时表"
        db_table = verbose_name
        verbose_name_plural = verbose_name
        unique_together = ('chapter', 'section_link')


class PricePolicy(models.Model):
    """价格策略表"""

    # 多个表之间的关系，如何处理，这里的一个方案，好好体会
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)  # 关联course or degree_course
    object_id = models.PositiveIntegerField()

    # 不生成表字段content_object，但是在表操作时，是个好东西
    content_object = GenericForeignKey('content_type', 'object_id')

    # 购买不同时间长度的课程，价格不同，赚钱的本质在这里
    valid_period_choices = ((1, '1天'), (3, '3天'),
                            (7, '1周'), (14, '2周'),
                            (30, '1个月'),
                            (60, '2个月'),
                            (90, '3个月'),
                            (120, '4个月'),
                            (180, '6个月'), (210, '12个月'),
                            (540, '18个月'), (720, '24个月'),
                            (722, '24个月'), (723, '24个月'),
                            )
    valid_period = models.SmallIntegerField(choices=valid_period_choices)
    price = models.FloatField()

    def __str__(self):
        # print时，看见的效果，自定义展示效果
        return "%s(%s)%s" % (self.content_object, self.get_valid_period_display(), self.price)

    class Meta:
        verbose_name = "08-价格策略表"
        db_table = verbose_name
        verbose_name_plural = verbose_name
        unique_together = ("content_type", 'object_id', "valid_period")


class OftenAskedQuestion(models.Model):
    """
    常见问题

    content_type 哪张表的评论
    object_id 对应评论表中的哪条数据
    question 评论这条数据的提问
    answer 评论这条数据的答案
    """
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)  # 关联course or degree_course
    object_id = models.PositiveIntegerField()
    # GenericForeignKey 不会在表中生成字段
    content_object = GenericForeignKey('content_type', 'object_id')

    question = models.CharField(max_length=255)
    answer = models.TextField(max_length=1024)

    def __str__(self):
        return "%s-%s" % (self.content_object, self.question)

    class Meta:
        verbose_name = "09-常见问题表"
        db_table = verbose_name
        verbose_name_plural = verbose_name
        unique_together = ('content_type', 'object_id', 'question')


class Comment(models.Model):
    """通用的评论表"""
    content_type = models.ForeignKey(ContentType, blank=True, null=True, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField(blank=True, null=True)
    content_object = GenericForeignKey('content_type', 'object_id')

    # 每一个评论内容都是 一个具体的用户评论的，评论的内容是哪一个课程如何如何...
    # 因此， 要有关联 一个具体的用户
    content = models.TextField(max_length=1024, verbose_name="评论内容")
    account = models.ForeignKey("Account", verbose_name="会员名", on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)  # 每一个评论，自动添加上评论时的时间

    def __str__(self):
        return self.content

    class Meta:
        verbose_name = "10-评价表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class Account(models.Model):
    username = models.CharField(max_length=32, verbose_name="用户姓名")
    pwd = models.CharField(max_length=32, verbose_name="密文密码")
    # head_img = models.CharField(max_length=256, default='/static/frontend/head_portrait/logo@2x.png',
    #                             verbose_name="个人头像")
    balance = models.IntegerField(verbose_name="贝里余额", default=0)

    def __str__(self):
        return self.username

    class Meta:
        verbose_name = "11-用户表"
        db_table = verbose_name
        verbose_name_plural = verbose_name


class CourseOutline(models.Model):
    """课程大纲"""
    course_detail = models.ForeignKey(to="CourseDetail", related_name="course_outline", on_delete=models.CASCADE)
    title = models.CharField(max_length=128)
    order = models.PositiveSmallIntegerField(default=1)
    # 前端显示顺序

    content = models.TextField("内容", max_length=2048)

    def __str__(self):
        return "%s" % self.title

    class Meta:
        verbose_name = "12-课程大纲表"
        db_table = verbose_name
        verbose_name_plural = verbose_name
        unique_together = ('course_detail', 'title')
