/*
SQLyog Ultimate v11.25 (64 bit)
MySQL - 5.5.28-log : Database - db2017
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `db2017`;

/*Table structure for table `tbl_class` */

DROP TABLE IF EXISTS `tbl_class`;

CREATE TABLE `tbl_class` (
  `class_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '班级ID',
  `caption` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_class` */

insert  into `tbl_class`(`class_id`,`caption`) values (1,'0808'),(2,'0829'),(3,'0919');

/*Table structure for table `tbl_course` */

DROP TABLE IF EXISTS `tbl_course`;

CREATE TABLE `tbl_course` (
  `course_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `teacher_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_course` */

insert  into `tbl_course`(`course_id`,`name`,`teacher_id`) values (1,'java',1),(2,'spring',2),(3,'mybatis',3),(4,'h5',4),(5,'git',5);

/*Table structure for table `tbl_score` */

DROP TABLE IF EXISTS `tbl_score`;

CREATE TABLE `tbl_score` (
  `score_id` int(10) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`score_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_score` */

insert  into `tbl_score`(`score_id`,`student_id`,`course_id`,`number`) values (1,1,1,58),(2,2,1,78),(3,3,1,78),(4,2,2,89),(5,1,2,98),(6,4,3,100),(7,1,3,99),(8,1,4,91),(9,1,5,71),(10,2,3,99),(11,2,4,79),(12,2,5,59),(13,3,2,99),(14,3,3,99),(15,3,4,69),(16,3,5,49),(17,4,1,69),(18,4,2,59),(19,4,4,84),(20,4,5,80),(21,5,1,49),(22,5,2,68),(23,5,3,67),(24,5,4,89);

/*Table structure for table `tbl_student` */

DROP TABLE IF EXISTS `tbl_student`;

CREATE TABLE `tbl_student` (
  `student_id` int(10) NOT NULL AUTO_INCREMENT,
  `class_id` int(10) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_student` */

insert  into `tbl_student`(`student_id`,`class_id`,`name`,`gender`) values (1,1,'张三','男'),(2,1,'李四','男'),(3,2,'李五','男'),(4,2,'李红','女'),(5,3,'李丽','女');

/*Table structure for table `tbl_teacher` */

DROP TABLE IF EXISTS `tbl_teacher`;

CREATE TABLE `tbl_teacher` (
  `teacher_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_teacher` */

insert  into `tbl_teacher`(`teacher_id`,`name`) values (1,'佟刚'),(2,'张晨'),(3,'封捷'),(4,'李贺飞'),(5,'李玉婷');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;




/*题目要求*/
#试题一、找出平均成绩大于60的所有学生的学号（即student_id)、姓名和平均分数

SELECT t.student_id,t.name,AVG(t.number) 
FROM (  SELECT a.`student_id` AS stuid,a.`name`,b.`student_id`,b.`number` 
	FROM tbl_student a INNER JOIN tbl_score b ON a.`student_id` = b.`student_id`) t
 GROUP BY student_id HAVING AVG(number)>60 

SELECT a.`student_id`,c.`name`,AVG(a.number) 
FROM tbl_score a  INNER JOIN tbl_course  b ON a.course_id = b.course_id 
		  INNER JOIN tbl_student c ON a.`student_id` = c.`student_id`
		  GROUP BY a.student_id HAVING AVG(a.number)>60 


SELECT b.`student_id`,a.`name`,AVG(b.number) AS avg_number
FROM tbl_student a INNER JOIN tbl_score b ON a.`student_id` = b.`student_id`
GROUP BY b.`student_id` HAVING AVG(b.number)>60 

#试题二、查询所有学生的学号，姓名，选课数和总成绩；
SELECT t.student_id,a.name,t.totalcourse,t.totalnumber FROM tbl_student a INNER JOIN
(SELECT student_id,COUNT(course_id) totalcourse,SUM(number) totalnumber 
	FROM tbl_score GROUP BY student_id ) t ON t.student_id = a.student_id 

SELECT a.student_id,b.name,COUNT(a.course_id),SUM(a.number) FROM tbl_score a INNER JOIN
tbl_student b ON a.student_id = b.student_id GROUP BY a.student_id;

#试题三、查找名字中含“封”字的老师的总数
SELECT COUNT(teacher_id) FROM tbl_teacher WHERE NAME LIKE '%佟%';


#试题四、查询没有学过李玉婷老师课的同学的学号、姓名
SELECT a.student_id,a.name 
FROM tbl_student a WHERE a.student_id NOT IN 
  (SELECT student_id FROM tbl_score WHERE course_id = 
    (SELECT course_id FROM tbl_course WHERE teacher_id = 
    (SELECT teacher_id FROM tbl_teacher WHERE NAME = '李玉婷')))

#试题五、查询学过"4"且学过编号"5"课程的同学的学号
SELECT 
	a.student_id
FROM 		
	(SELECT * FROM tbl_score WHERE course_id = 4) a 
INNER JOIN 
	(SELECT * FROM tbl_score WHERE course_id = 5) b
ON a.student_id = b.student_id;

#试题六、查询编号"1"成绩比编号"2"成绩低的学生的学号
SELECT 
	t1.student_id,t1.course_id,t1.number,t2.course_id,t2.number 
FROM
	(SELECT student_id,course_id,number FROM tbl_score WHERE course_id = 1) t1
INNER JOIN
	(SELECT student_id,course_id,number FROM tbl_score WHERE course_id = 2) t2
ON 
	t1.student_id = t2.student_id 
WHERE 
	t1.number < t2.number	ORDER BY t1.student_id;
	
#试题七、找出有一门课程低于60分的学生的学号和名字

SELECT t2.student_id,t1.name FROM tbl_student t1
INNER JOIN
(SELECT student_id,MIN(number) FROM tbl_score 
GROUP BY student_id HAVING MIN(number)<60) t2 
ON t1.student_id = t2.student_id;

#试题八、查询选完全部课程的学生的学号
SELECT t1.student_id,COUNT(t2.`course_id`) AS totalCourse 
FROM tbl_score t1 INNER JOIN tbl_course t2 ON t1.`course_id` = t2.`course_id` 
GROUP BY t1.`student_id` 
HAVING totalCourse = (SELECT COUNT(course_id) FROM tbl_course);

#试题九、按平均成绩从高到低，显示所有学生的各科课程成绩

SELECT 
	t.student_id,t.course_id,t.number,b.avgScore 
FROM 
	tbl_score t 
LEFT JOIN 
	(SELECT student_id,AVG(number) AS avgScore FROM tbl_score GROUP BY student_id) b 
ON t.`student_id` = b.student_id  
ORDER BY avgScore DESC;

#试题十、查询各科成绩的最高分和最低分及对应的学生学号。
SELECT * FROM (
SELECT a.`course_id`,a.`student_id`,b.max_number FROM tbl_score a INNER JOIN
(SELECT course_id,MAX(number) max_number FROM tbl_score GROUP BY course_id) b 
ON a.`course_id` = b.course_id
WHERE a.`number` = b.max_number ) x1 
INNER JOIN (
SELECT c.`course_id`,c.`student_id`,d.min_number  FROM tbl_score c INNER JOIN
(SELECT course_id,MIN(number) min_number FROM tbl_score GROUP BY course_id) d 
ON c.`course_id` = d.course_id
WHERE c.`number` = d.min_number ) x2
ON x1.course_id = x2.course_id 
ORDER BY x1.course_id;




