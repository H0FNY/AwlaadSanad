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

class StudentService {
  String BaseUrl = 'http://welads.runasp.net/classtrack/';

  Future getAllStudents() async {
    Uri url = Uri.parse("${BaseUrl}Student/GetAll");
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
  Future getStudentInGroup(int id) async {
    Uri url = Uri.parse("${BaseUrl}Student/studentsingroup/${id}");
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

  // Future postStudentAdd(String name) async {
  //   Uri url = Uri.parse("${BaseUrl}Student/add");
  //   Map<String, String> requestBody = {
  //     "name": name,
  //     "groupId": "1"
  //   };
  //
  //   try {
  //     http.Response response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Response: ${response.body}');
  //     } else {
  //       print('Failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  // Future postStudentUpdate(int id,String name) async {
  //   Uri url = Uri.parse("${BaseUrl}Student/update/$id");
  //   Map<String, String> requestBody = {
  //     "name": name,
  //   };
  //
  //   try {
  //     http.Response response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Response: ${response.body}');
  //     } else {
  //       print('Failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  Future postStudentDelete(int id) async {
    Uri url = Uri.parse("${BaseUrl}Student/delete/$id");
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
        print('Response: ${response.body}');
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

  Future<http.Response> deleteUser (String username) async {
    Uri url = Uri.parse("${BaseUrl}/User/Delete/$username");

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