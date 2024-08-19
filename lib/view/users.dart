import 'package:flutter/material.dart';
import '../custom/colors.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<String> users = [
    "عامر دياب",
    "احمد ونس",
    "زكريا حجاج",
  ];

  List<String> role = [
    "1",
    "2",
    "2",
  ];
  List<String> group = [
    "-",
    "عمر بن الخطاب",
    "عثمان بن عفان",
  ];
  void _showAddDialog() {
    String name = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "إضافة مستخدم",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "الاسم",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "الوظيفة",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "المجموعة",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "اسم المستخدم",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "كلمة المرور",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (name.isNotEmpty) {
                    users.add(name);
                    Navigator.of(context).pop();
                    setState(() {});
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'لم يتم اضافة المستخدم',
                        textAlign: TextAlign.end,
                      ),
                    ));
                  }
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  "لا",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteStudent(int id) {
    users.removeAt(id);
    group.removeAt(id);
    role.removeAt(id);
    setState(() {});
  }
  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "هل تريد حذف المستخدم ؟",
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  deleteStudent((id));
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  "لا",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(String user) {
    String name = "";
    String roleId = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "تعديل علي بيانات ${user}",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "الاسم",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "الوظيفة",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "المجموعة",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "اسم المستخدم",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "كلمة المرور",
                      helperStyle: TextStyle(
                      )
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if(name.isNotEmpty) {
                    Navigator.of(context).pop();
                    setState(() {});
                  }
                  else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'لم يتم اضافة المجموعة',
                        textAlign: TextAlign.end,
                      ),
                    ));
                  }
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  "لا",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
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
          title: Text(
            'المستخدمين',
            style: TextStyle(
              color: whiteColor,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              color: whiteColor,
              onPressed: _showAddDialog,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0,left: 20,top: 10),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onLongPress: (){
                            _showDeleteDialog(index);
                          },
                          child: Text(
                            users[index],
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              role[index]=="1" ? "مسؤول": "مدرس",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: screenW/15,),
                            Container(
                              width: screenW/2.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      group[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  IconButton(onPressed: (){
                                    _showEditDialog(users[index]);
                                  }, icon: Icon(Icons.edit),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: mainColor,),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
