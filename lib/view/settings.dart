import 'package:awladsanaad_2/view/users.dart';
import 'package:flutter/material.dart';

import '../custom/colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: mainColor,
          elevation: 10,
          backgroundColor: mainColor,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back),color: whiteColor,),
          title: const Text(
            "اعدادت",style: TextStyle(color: whiteColor ,fontWeight: FontWeight.bold,),),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Users()),
                );
              }, icon: Icon(Icons.person),color: whiteColor,),
          ],
        ),
      ),
    );
  }
}
