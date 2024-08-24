import 'package:awladsanaad_2/services.dart';
import 'package:awladsanaad_2/view/auth/_login_cubit.dart';
import 'package:flutter/material.dart';

class testt extends StatelessWidget {
  const testt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        // IconButton(onPressed: (){usersService().logout();}, icon: Icon(Icons.add)),
        IconButton(onPressed: (){LoginCubit().logout();}, icon: Icon(Icons.add)),
        IconButton(onPressed: (){GroupService().getAllGroups();}, icon: Icon(Icons.update)),
        // IconButton(onPressed: (){studentService().postStudentUpdate(7,"احمد حفني");}, icon: Icon(Icons.delete)),
        IconButton(onPressed: (){StudentService().getAllStudents();}, icon: Icon(Icons.save)),
      ],),
    );
  }
}