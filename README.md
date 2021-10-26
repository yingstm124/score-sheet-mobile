# Android Application for Handwritten Examiner and Score Number Recognition on Cover Page of Answer Sheet.

แอนดรอย์แอปพลิเคชันสำหรับการรู้จำรหัสผู้สอบและคะแนนสอบบนหน้าปกกระดาษคำตอบ
อ ที่ปรึกษา : ผู้ช่วยศาสตราจารย์ เบญจมาศ ปัญญางาม

  The objective of this independent study is to develop android application for handwritten examiner and score number recognition on cover page picture of answer sheet. This application is used as a tool for teacher to record scores and reduce human errors. The teacher can input cover page pictures of answer sheets through mobile application to recognize examiner code and score number. The application can also generate the examiner score report in Excel format. Moreover, the task of test information management, such as adding, editing, removing test detail, and student information management such as adding student detail from CSV format file are also be done by the application.
	To develop this application, the system architecture divided into 3 parts. The first part is mobile application as teacher interaction tool. This part is developed by using Flutter framework. The Second part is Application Interface (API) used as connection between mobile application, system database, and prediction model. This prediction model can learn to recognize the examiner code and score number by applying Convolutional Neural Networks (CNNs) library, Keras Library.  In this model, the digits are learned from 60,000 Mnist datasets. The third part is a relational database to collect data of system by using SQL Server.
	The application testing has been verified to work correctly and completely in which 50 cover page pictures on answer sheets are used for testing the examiner and score number recognition. The application can average 89.3% identify digits between 0 to 9 correctly. Moreover, teacher able to handle the test and student information through this application.


