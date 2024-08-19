import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class attendetypeService {
  String BaseUrl = 'http://welads.runasp.net/api/';

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
      // Send the POST request
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody), // Convert your data to JSON format
      );

      if (response.statusCode == 200) {
        // Request was successful, you can handle the response here
        print('Response: ${response.body}');
      } else {
        // Handle server errors
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle connection or other errors
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

class groupService {
  String BaseUrl = 'http://welads.runasp.net/api/';

  Future getAllGroups() async {
    Uri url = Uri.parse("${BaseUrl}Group/viewgroups");
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
  Future postGroupAdd(String name) async {
    Uri url = Uri.parse("${BaseUrl}Group/addgroup");
    Map<String, String> requestBody = {
      "name": name,
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


  // Future postGroupUpdate(int id,String name) async {
  //   Uri url = Uri.parse("${BaseUrl}Group/updategroup/$id");
  //   Map<String, String> requestBody = {
  //     "name": name,
  //   };
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


  Future postGroupDelete(int id) async {
    Uri url = Uri.parse("${BaseUrl}Group/deletegroup/$id");
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


class studentService {
  String BaseUrl = 'http://welads.runasp.net/api/';

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

class usersService {
  String BaseUrl = 'http://welads.runasp.net/api/';

  Future logout() async {
    Uri url = Uri.parse("${BaseUrl}Auth/logout");
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IkFkbWluIiwibmFtZWlkIjoiZDEyM2U0ODAtNDdmNS00N2RmLTlhNWMtZTIyMjRlNWI2NDNkIiwibmJmIjoxNzIzOTMzNTE1LCJleHAiOjE3MjM5NDA3MTUsImlhdCI6MTcyMzkzMzUxNSwiaXNzIjoiV2VsYWRTIiwiYXVkIjoiaHR0cDovL1dlbGFkUy5ydW5hc3AubmV0LyJ9.waQJnaLAWBOfzpiyfXqHdX6qnAjhWaIuatfKaPXo5V0',
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

  Future login(String username,String password) async {
    Uri url = Uri.parse("${BaseUrl}Auth/login");
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

      if (response.statusCode == 200) {
        Map<String, dynamic> hasExpired = JwtDecoder.decode(response.body);

        print(hasExpired);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  // Future postGroupUpdate(int id,String name) async {
  //   Uri url = Uri.parse("${BaseUrl}Group/updategroup/$id");
  //   Map<String, String> requestBody = {
  //     "name": name,
  //   };
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


  Future postGroupDelete(int id) async {
    Uri url = Uri.parse("${BaseUrl}Group/deletegroup/$id");
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