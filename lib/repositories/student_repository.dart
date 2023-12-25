import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/models/student.dart';
import 'package:flutter_application_2/services/api_service.dart';

class StudentRepository {
  final ApiService api = ApiService();

  Future<bool> dangkyLop() async {
    bool kq = false;
    var response = await api.dangkyLop();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<Student> getStudentInfo() async {
    Student student = Student();
    var response = await api.getStudentInfo();
    if (response != null) {
      var data = response.data;
      student = Student.fromJson(data);
      // Profile().student = Student.fromStudent(student);
    }
    return student;
  }
}
