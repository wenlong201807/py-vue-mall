from rest_framework import serializers
from Student.models import Clas, CourseSchool


class ClssSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clas
        fields = "__all__"


class CourseSchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = CourseSchool
        fields = "__all__"
