
from rest_framework import serializers
from . import models


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Category
        fields = "__all__"


# 前端需要什么数据，全看序列化器的设计【工厂函数的模式】
class CourseSerializer(serializers.ModelSerializer):
    # level 对应的是一个元组 level_choices = ((0, '初级'), (1, '中级'), (2, '高级'))
    # 如此写法，直接返回对应的中文
    level = serializers.CharField(source="get_level_display")

    # 具体返回的价格，看get_price 函数的返回值
    # 课程表中没有price 这个字段，前端却要展示
    price = serializers.SerializerMethodField()
    def get_price(self, obj):
        # price_policy = GenericRelation("PricePolicy")
        # 反向查询的妙用之处，可以直接 调用对应表模型 obj.price_policy
        print(obj.price_policy.all())
        # 拿到了整个价格策略表的所有数据，
        # 做生意嘛，这里只展示最便宜的那个
        price_obj = obj.price_policy.all()  # 查询规则：映射关系是 当前Course表主键 id -> 关联表PricePolicy 的字段 object_id
        if not price_obj:
            return 1.9
        return obj.price_policy.all().order_by("price").first().price

    class Meta:
        model = models.Course
        fields = ["id", "title", "course_img", "brief", "level", "study_num", "price"]


class CourseDetailSerializer(serializers.ModelSerializer):

    '''
    source="course.get_level_display": 在课程表中，有level 字段，展示一个元组，可通过此映射操作获取中文
    level_choices = ((0, '初级'), (1, '中级'), (2, '高级'))
    level = models.SmallIntegerField(choices=level_choices, default=1)
    '''
    level = serializers.CharField(source="course.get_level_display")

    # course_detail 表中无此字段，但是要求返回study_num 这个字段，自己组装上去
    # 数据怎么确定呢？ 通过关联表 确定 -> source="course.study_num"
    study_num = serializers.IntegerField(source="course.study_num")

    # 需要返回接口的字段，返回内容看 函数get_course_outline(self, obj)的返回值
    recommend_courses = serializers.SerializerMethodField()
    teachers = serializers.SerializerMethodField()
    price_policy = serializers.SerializerMethodField()
    course_outline = serializers.SerializerMethodField()

    # 参数obj 是 models.py 中 对应class【CourseDetail】中定义的属性名【recommend_courses】
    def get_recommend_courses(self, obj):
        return [{"id": course.id, "title": course.title} for course in obj.recommend_courses.all()]

    # 参数obj 是 models.py 中 对应class【CourseDetail】中定义的属性名【teachers】
    def get_teachers(self, obj):
        return [{"id": teacher.id, "name": teacher.name} for teacher in obj.teachers.all()]

    # 价格策略表是整个项目中，各个表都可能有对应的关联关系，因此 课程详情表 需要先转入 课程表 再 获取 对应id-object_id 的价格策略列表
    # -> obj.course.price_policy.all()
    # 元组中，展示中文 price.get_valid_period_display()
    def get_price_policy(self, obj):
        return [{"id": price.id, "valid_price_display": price.get_valid_period_display(), "price": price.price} for price in obj.course.price_policy.all()]

    # class CourseOutline(models.Model): 课程大纲表中有外键关联的 属性。可以用于所关联的主表查询使用
    # course_detail = models.ForeignKey(to="CourseDetail", related_name="course_outline", on_delete=models.CASCADE)
    # 课程详情表 与 课程大纲有 外键关联关系，那么在 主表中可使用 外键关联表的 related_name 做反向查询
    def get_course_outline(self, obj):
        return [{"id": outline.id, "title": outline.title, "content": outline.content} for outline in obj.course_outline.all().order_by("order")]





    class Meta:
        model = models.CourseDetail
        fields = ["id", "hours", "summary", "level", "study_num", "recommend_courses", "teachers",
                  "price_policy", "course_outline"]


class CourseChapterSerializer(serializers.ModelSerializer):
    # 构建section 返回的数据结构
    sections = serializers.SerializerMethodField()
    def get_sections(self, obj):
        # 正向查询 CourseChapter外键关联的子表【课时表】，的所有数据
        # chapter = models.ForeignKey(to="CourseChapter", related_name="course_sections", on_delete=models.CASCADE)
        return [{"id": section.id, "title": section.title, "free_trail": section.free_trail} for section in obj.course_sections.all().order_by("section_order")]

    class Meta:
        model = models.CourseChapter
        fields = ["id", "title", "sections"]


class CourseCommentSerializer(serializers.ModelSerializer):
    # 评论表中 有 account = models.ForeignKey("Account", verbose_name="会员名", on_delete=models.CASCADE)
    account = serializers.CharField(source="account.username")

    class Meta:
        model = models.Comment
        fields = ["id", "account", "content", "date"]


class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OftenAskedQuestion
        fields = ["id", "question", "answer"]