import 'package:awladsanaad_2/services.dart';
import 'package:flutter/material.dart';

class testt extends StatelessWidget {
  const testt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        // IconButton(onPressed: (){usersService().login("afd");}, icon: Icon(Icons.add)),
        IconButton(onPressed: (){groupService().getAllGroups();}, icon: Icon(Icons.update)),
        // IconButton(onPressed: (){studentService().postStudentUpdate(7,"احمد حفني");}, icon: Icon(Icons.delete)),
        IconButton(onPressed: (){studentService().getAllStudents();}, icon: Icon(Icons.save)),
      ],),
    );
  }
}