from rest_framework import serializers
from . import models


class ClssSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Clas
        fields = "__all__"


class StuCourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.StuCourse
        fields = "__all__"
