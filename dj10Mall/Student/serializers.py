from rest_framework import serializers
from . import models


class ClssSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Clas
        fields = "__all__"


class CourseSchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CourseSchool
        fields = "__all__"
