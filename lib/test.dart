import 'package:awladsanaad_2/services.dart';
import 'package:awladsanaad_2/view/auth/_login_cubit.dart';
import 'package:awladsanaad_2/view/auth/logIn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class testt extends StatelessWidget {
  const testt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        // IconButton(onPressed: (){usersService().logout();}, icon: Icon(Icons.add)),
        IconButton(
            onPressed: () async {
          LoginCubit().logout();Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('Username');
         prefs.remove('Password');
        }, icon: Icon(Icons.add)),
        IconButton(onPressed: (){GroupService().getAllGroups();}, icon: Icon(Icons.update)),
        // IconButton(onPressed: (){studentService().postStudentUpdate(7,"احمد حفني");}, icon: Icon(Icons.delete)),
        // IconButton(onPressed: (){AttendanceService().addAttendance("", date, sId, aId);}, icon: Icon(Icons.save)),
      ],),
    );
  }
}