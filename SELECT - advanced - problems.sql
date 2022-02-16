USE StudentsBaseSmall;

--Выражение "выведите студентов" означает вывод IIN, LasName, FirstName с требуемыми дополнительными данными.
--Выражение "выведите группы" означает вывод GroupID, GroupName с требуемыми дополнительными данными.
--Выражение "выведите курсы" означает вывод Course, CourseName с требуемыми дополнительными данными.


--Выведите группы с количеством студентов.
SELECT Groups.GroupID, GroupName, COUNT(StudentID) AS StudCount
  FROM Students
    INNER JOIN Groups ON Students.GroupID = Groups.GroupID
  GROUP BY Groups.GroupID, GroupName
  ORDER BY GroupName;
	
--Выведите группы с количеством сдаваемых экзаменов студентами групп.   
SELECT Groups.GroupID, GroupName, COUNT(Exams.StudentID) AS ExamsCount
  FROM Exams
  	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Groups ON Groups.GroupID = Students.GroupID
  GROUP BY Groups.GroupID, GroupName
  ORDER BY ExamsCount DESC;

--Выведите студентов со средней оценкой и суммой ExamFee.
SELECT Students.StudentID, Students.IIN, Students.LastName, Students.FirstName,  AVG(Grade + 0.0) AS AvgGrade, SUM(ExamFee) AS FeeSum
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
  GROUP BY Students.IIN, Students.LastName, Students.FirstName, Students.StudentID
  ORDER BY FeeSum DESC;

--Выведите группы со средней оценкой и суммой ExamFee.
SELECT Groups.GroupID, GroupName, AVG(Grade + 0.0) AS AvgGrade, SUM(ExamFee) AS FeeSum
  FROM Exams
  	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Groups ON Groups.GroupID = Students.GroupID
  GROUP BY Groups.GroupID, GroupName
  ORDER BY FeeSum DESC;

--Выведите курсы со средней оценкой и суммой ExamFee.
SELECT Courses.CourseID, Courses.CourseName,  AVG(Grade + 0.0) AS AvgGrade, SUM(ExamFee) AS FeeSum
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY FeeSum DESC;


--Выведите курсы с количеством сдаваемых экзаменов, средней оценкой и суммой ExamFee.

SELECT Courses.CourseID, Courses.CourseName, COUNT(Exams.StudentID) AS ExamsCount, AVG(Grade + 0.0) AS AvgGrade, SUM(ExamFee) AS FeeSum
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY ExamsCount DESC;

--Выведите курсы в порядке возрастания средней оценки. 
SELECT Courses.CourseID, Courses.CourseName, AVG(Grade + 0.0) AS AvgGrade
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY AvgGrade;

--Выведите курсы в порядке убывания суммы ExamFee.
SELECT Courses.CourseID, Courses.CourseName, SUM(ExamFee) AS FeeSum
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY FeeSum DESC;

--Выведите курсы с количеством их сдававших студентов в порядке убывания количества.
SELECT Courses.CourseID, Courses.CourseName, COUNT(Exams.StudentID) AS StudExamsCount
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY StudExamsCount DESC;

--Выведите курсы, по которым не было ни одной оценки ниже заданной, в заданном интервале дат. 
SELECT Courses.CourseID, Courses.CourseName
  FROM Exams
	INNER JOIN Students ON Students.StudentID = Exams.StudentID
	INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
	WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01' AND Grade >= 6
  GROUP BY Courses.CourseID, Courses.CourseName
  ORDER BY CourseID;

--Выведите студентов, имеющих хоть один заваленный экзамен.  
SELECT Students.StudentID, IIN, LastName, FirstName, Grade
  FROM Students 
  INNER JOIN Exams ON Students.StudentID = Exams.StudentID
  WHERE Grade < 6
  GROUP BY  Students.StudentID, IIN, LastName, FirstName, Grade
  ORDER BY Students.StudentID, Grade;

--Выведите студентов, не имеющих ни одного заваленного экзамена.  
SELECT Students.StudentID, IIN, LastName, FirstName, Grade
  FROM Students 
  INNER JOIN Exams ON Students.StudentID = Exams.StudentID
  WHERE Grade > 6
 GROUP BY  Students.StudentID, IIN, LastName, FirstName, Grade
 ORDER BY Students.StudentID, Grade;

--Выведите группы, где имеются студенты, завалившие хоть один экзамен в заданном интервале дат. 

SELECT Groups.GroupID, GroupName
  FROM  Groups
  INNER JOIN Students ON Groups.GroupID = Students.GroupID
  INNER JOIN Exams ON Students.StudentID = Exams.StudentID
  WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01' AND Grade < 6
  GROUP BY  Groups.GroupID, GroupName
  ORDER BY Groups.GroupID, GroupName;

--Выведите группы, где нет студентов, заваливших хоть один экзамен в заданном интервале дат. 
SELECT Groups.GroupID, GroupName
  FROM  Groups
  INNER JOIN Students ON Groups.GroupID = Students.GroupID
  INNER JOIN Exams ON Students.StudentID = Exams.StudentID
  WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01' AND Grade > 6
  GROUP BY  Groups.GroupID, GroupName
  ORDER BY Groups.GroupID, GroupName;

--Выведите курсы, по которым имеются студенты, завалившие хоть один экзамен в заданном интервале дат. 
SELECT Courses.CourseID, Courses.CourseName
  FROM  Courses
  INNER JOIN Exams ON Courses.CourseID = Exams.CourseID
  INNER JOIN Students ON Exams.StudentID = Students.StudentID
  WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01' AND Grade < 6
  GROUP BY  Courses.CourseID, Courses.CourseName
  ORDER BY Courses.CourseID, Courses.CourseName;


--Выведите курсы, по которым нет студентов, заваливших хоть один экзамен в заданном интервале дат.
SELECT Courses.CourseID, Courses.CourseName
  FROM  Courses
  INNER JOIN Exams ON Courses.CourseID = Exams.CourseID
  INNER JOIN Students ON Exams.StudentID = Students.StudentID
  WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01' AND Grade > 6
  GROUP BY  Courses.CourseID, Courses.CourseName
  ORDER BY Courses.CourseID, Courses.CourseName;


--Выведите группы и курсы, по которым имелись оценки 12 баллов в заданном интервале дат. Упорядочьте по названию курса и, затем, по названию группы.
SELECT Groups.GroupID, Groups.GroupName, Courses.CourseID, Courses.CourseName, Grade
  FROM  Groups
  INNER JOIN Students ON Groups.GroupID = Students.GroupID
  INNER JOIN Exams ON Exams.StudentID = Students.StudentID
  INNER JOIN Courses ON Courses.CourseID = Exams.CourseID
  WHERE Grade = 12 AND  ExamDate BETWEEN '2010-01-01' AND '2020-01-01'
  GROUP BY Groups.GroupID, Groups.GroupName, Courses.CourseID, Courses.CourseName, Grade
  ORDER BY Courses.CourseName, Groups.GroupName;


--HAVING
--Выведите студентов со средней оценкои менее 6 баллов.


--Выведите студентов со средней оценкои более 8 баллов, за экзамены, сдававшиеся в заданном интервале дат.
SELECT StudentID, AVG(Grade) AS AvgGrade
  FROM Exams
	WHERE ExamDate BETWEEN '2010-01-01' AND '2020-01-01'
  GROUP BY StudentID
	HAVING AVG(Grade) >= 8
  ORDER BY AvgGrade;


--Выведите студентов с суммой ExamFee, превышающей  заданное значение. 
SELECT StudentID, SUM(ExamFee) AS FeeSum
  FROM Exams
	WHERE ExamDate >= '20100101' AND ExamDate >= '20200101'
  GROUP BY StudentID
	HAVING SUM(ExamFee) >= 100
  ORDER BY StudentID;

--Выведите группы с количеством студентов, превышающим заданное значение.
SELECT GroupID, COUNT(StudentID) AS StudCount
  FROM Students
  GROUP BY GroupID
	HAVING COUNT(StudentID) > 10
  ORDER BY GroupID; 

--Выведите курсы со средней оценкой меньше, чем заданное значение.

SELECT CourseID, AVG(Grade) AS AvgGrade
  FROM Exams
  GROUP BY CourseID
	HAVING AVG(Grade) <= 6
  ORDER BY CourseID;


--UNION
--В базе StudentsBaseSmall создайте таблицу Teachers с полями IIN, LastName, FistName.
DROP TABLE IF EXISTS Teachers
CREATE TABLE Teachers (
  TeacherID BIGINT NOT NULL PRIMARY KEY IDENTITY,
  IIN CHAR(12) NOT NULL,
  LastName NVARCHAR(20) NOT NULL,
  FirstName NVARCHAR(20) NOT NULL,
);

INSERT INTO Teachers (IIN, LastName, FirstName) VALUES ('111111111111', 'Ullrich', 'Rita');
INSERT INTO Teachers (IIN, LastName, FirstName) VALUES ('222222222222', 'Pooh', 'Winny');
INSERT INTO Teachers (IIN, LastName, FirstName) VALUES ('333333333333', 'Робин', 'Кристофер');
INSERT INTO Teachers (IIN, LastName, FirstName) VALUES ('444444444444', 'Gerlach', 'Vito');


--По образцу примеров в файле "SELECT - UNION.sql" приведите демонстрацию команд UNION, UNION ALL для таблиц Students и Teachers.

SELECT LastName FROM Students  --UNION исключает дублирование в результатах
UNION
SELECT LastName FROM Teachers
ORDER BY LastName;


-------------------------------------------------------------------------------
-- UNION ALL
-------------------------------------------------------------------------------

SELECT LastName FROM Students --UNION ALL не удаляет дублирующие записи в результатах
UNION ALL 
SELECT LastName FROM Teachers
ORDER BY LastName;


SELECT LastName, IIN FROM Students
WHERE LastName='Gerlach'
UNION ALL
SELECT LastName, IIN FROM Teachers
WHERE LastName='Ullrich'
ORDER BY LastName;


SELECT 'Students' AS Type, FirstName, LastName, IIN
FROM Students
UNION
SELECT 'Teachers', FirstName, LastName, IIN
FROM Teachers;

	
--Приведите убедительный пример их различий в результатах. 

 --UNION исключает дублирование в результатах
	SELECT LastName FROM Students ----UNION исключает дублирование (выдаст около 400-500)
	UNION  
	SELECT LastName FROM Teachers
	ORDER BY LastName;

 --UNION ALL не удаляет дублирования в результатах (выдаст все строки около 10 000)
    SELECT LastName FROM Students --UNION ALL выводит без исключения дублирования
	UNION ALL 
	SELECT LastName FROM Teachers
	ORDER BY LastName;

	