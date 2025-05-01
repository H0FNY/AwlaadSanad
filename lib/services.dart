import 'dart:convert';
import 'package:awladsanaad_2/custom/data.dart';
import 'package:awladsanaad_2/model/user_model.dart';
import 'package:http/http.dart' as http;

class AttendeTypeService {
  String BaseUrl = 'http://welads.runasp.net/classtrack/';

  Future getAllAttendenceType() async {
    Uri url = Uri.parse("${BaseUrl}AttendenceType/getall");
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future getAttendenceType(int id) async {
    Uri url = Uri.parse("${BaseUrl}AttendenceType/gettype/${id}");
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

  }
  Future postAttendenceTypeAdd(String type) async {
    Uri url = Uri.parse("${BaseUrl}AttendenceType/add");
    Map<String, String> requestBody = {
      "type": type,
    };

    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future postAttendenceTypeUpdate(int id,String type) async {
    Uri url = Uri.parse("${BaseUrl}AttendenceType/update/$id");
    Map<String, String> requestBody = {
      "type": type,
    };

    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future postAttendenceTypeDelete(int id) async {
    Uri url = Uri.parse("${BaseUrl}AttendenceType/delete/$id");
    try {
      http.Response response = await http.post(
        headers: {"Content-Type": "application/json"},
        url,
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class GroupService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';

  Future<http.Response> getAllGroups() async {
    final Uri url = Uri.parse("$BaseUrl/Group/GetAll");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );

      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<http.Response> addGroup(String name,UserModel teacher) async {
    Uri url = Uri.parse("$BaseUrl/Group/Add");

      Map<String, dynamic> requestBody= {
        "name": name,
        "TeacherId":teacher.id,
      };

    try {
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );
      print(response.statusCode);
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<http.Response> updateGroup(int id, String? name,UserModel? teacher) async {
    Uri url = Uri.parse("$BaseUrl/Group/Update/$id");
    Map<String, dynamic> requestBody= {
      if (name!.isNotEmpty) "name" : name,
        if (teacher != null) "TeacherId": teacher.id,
      };



    try {
      http.Response response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },

        body: jsonEncode(requestBody),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<http.Response> deleteGroup(int id) async {
    Uri url = Uri.parse("$BaseUrl/Group/Delete/$id");
    try {
      http.Response response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );

      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}

class AttendanceService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';

  Future<http.Response> getAllAttendance(String date) async {
    final Uri url = Uri.parse("$BaseUrl/Attendance/search/$date");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
  Future<http.Response> addAttendance(String desc,String date,int sId,int aId) async {
    Uri url = Uri.parse("$BaseUrl/Attendance/Add");

    Map<String, dynamic> requestBody= {
      "description":desc,
      "date":date,
      "studentId":sId,
      "attendId":aId
    };

    try {
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );
      print("add"+response.statusCode.toString());
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<http.Response> updateAttendance(int attendId,int id,String date) async {
    Uri url = Uri.parse("$BaseUrl/Attendance/Update/$id");
    Map<String, dynamic> requestBody= {
      "attendId":attendId,
      "date":date
    };
    try {
      http.Response response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );
      print("update"+response.statusCode.toString());
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
  Future<http.Response> updateDesc(int id,String desc) async {
    Uri url = Uri.parse("$BaseUrl/Attendance/Update/$id");
    Map<String, dynamic> requestBody= {
      "description":desc,
    };
    try {
      http.Response response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );
      print("update"+response.statusCode.toString());
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}

class StudentService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';

  Future<http.Response> getAllStudents() async {
    final Uri url = Uri.parse("$BaseUrl/Student/GetAll");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );

      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
  Future<http.Response> getDeactivatedStudents() async {
    final Uri url = Uri.parse("$BaseUrl/Student/DeactivatedStudents");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );

      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<http.Response> getStudentsByGroup(int id) async {
    final Uri url = Uri.parse("$BaseUrl/Student/StudentsInGroup/$id");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<http.Response> addStudent (String name,int groupId,String phone) async {
    Uri url = Uri.parse("${BaseUrl}/Student/Add");
    Map<String, dynamic> requestBody = {
      "name": name,
      "groupId": groupId,
      "PhoneNumber":phone,
    };

    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  Future<http.Response> updateStudent (String name,int groupId , int stdId,String phone) async {
    Uri url = Uri.parse("${BaseUrl}/Student/Update/$stdId");
    Map<String, dynamic> requestBody = {
      "name": name,
      "groupId": groupId,
      "PhoneNumber":phone,
    };

    try {
      http.Response response = await http.put(
        url,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
        body: jsonEncode(requestBody),
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  Future<http.Response> searchStudent (String name) async {
    Uri url = Uri.parse("${BaseUrl}/Student/Search/$name");

    try {
      http.Response response = await http.get(
        url,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }

  Future<http.Response> deleteStudent(int id) async {
    final Uri url = Uri.parse("$BaseUrl/Student/delete/$id");
    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
  Future<http.Response> deactivateStudent(int id) async {
    final Uri url = Uri.parse("$BaseUrl/Student/Deactivate/$id");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
  Future<http.Response> activateStudent(int id) async {
    final Uri url = Uri.parse("$BaseUrl/Student/activate/$id");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}

class AuthService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';
  Future logout() async {
    Uri url = Uri.parse("${BaseUrl}/Auth/logout");
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );

      if (response.statusCode == 200) {

      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<http.Response> login (String username,String password) async {
    Uri url = Uri.parse("${BaseUrl}/Auth/login");
    Map<String, String> requestBody = {
      "userName": username,
      "password": password
    };

    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}


class UsersService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';
  Future getAll() async {
    Uri url = Uri.parse("${BaseUrl}/User/GetAll");
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<http.Response> addUser (String username,String name,String password,String role) async {
    Uri url = Uri.parse("${BaseUrl}/Auth/register");
    Map<String, dynamic> requestBody= {
      "name": name,
      "userName":username,
      "role":role,
      "password": password
    };
    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer ${Userdata["token"]}',},
        body: jsonEncode(requestBody),
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  Future<http.Response> deleteUser (String username) async {
    Uri url = Uri.parse("${BaseUrl}/User/Delete/$username");
    try {
      http.Response response = await http.delete(
        url,
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer ${Userdata["token"]}',},
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}


class RolesService {
  String BaseUrl = 'http://welads.runasp.net/classtrack';
  Future getAll() async {
    Uri url = Uri.parse("${BaseUrl}/Role/GetAll");
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      return response;
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<http.Response> addRole(String name) async {
    Uri url = Uri.parse("$BaseUrl/ٌRole/Create/$name");
    try {
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${Userdata["token"]}',
        },
      );
      print(response.statusCode);
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
  Future<http.Response> deleteRole (String name) async {
    Uri url = Uri.parse("${BaseUrl}/User/Role/$name");

    try {
      http.Response response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      return response;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}