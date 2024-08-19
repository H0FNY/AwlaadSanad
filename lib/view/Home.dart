import 'package:awladsanaad_2/view/settings.dart';
import 'package:awladsanaad_2/test.dart';
import 'package:awladsanaad_2/view/table.dart';
import 'package:flutter/material.dart';

import '../custom/colors.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> groups = [
    "ابو بكر الصديق",
    "عمر بن الخطاب",
    "عثمان بن عفان",
    "علي بن ابي طالب",
    "عبدالرحمن بن عوف",
    "سعيد بن زيد",
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
              "إضافة مجموعة",
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              decoration: InputDecoration(
                  hintText: "اسم المجموعة", helperStyle: TextStyle()),
              onChanged: (value) {
                name = value;
              },
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (name.isNotEmpty) {
                    groups.add(name);
                    Navigator.of(context).pop();
                    setState(() {});
                  } else {
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

  void deletegroup(int id) {
    groups.removeAt(id);
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
              "هل تريد حذف المجموعة ؟",
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  deletegroup((id));
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

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          shadowColor: mainColor,
          elevation: 10,
          backgroundColor: mainColor,
          title: Text(
            'المجموعات',
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              icon: Icon(Icons.settings),
              color: whiteColor,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => testt()));
              },
              icon: Icon(Icons.g_translate),
              color: whiteColor,
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: whiteColor,
              onPressed: _showAddDialog,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 20),
          child: ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  _showDeleteDialog(index);
                },
                child: GroupWidget(
                  width: widthScreen,
                  groups: groups,
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.groups,
    required this.index,
    required this.width,
  });

  final List<String> groups;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mainColor,
      shadowColor: mainColor,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width/5,
                  child: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: mainColor),
                    ),
                    backgroundColor: whiteColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groups[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "احمد ونس",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      Text(
                        "20",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width/5,
                  child: CircleAvatar(
                      backgroundColor: whiteColor,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: table())),
                          );
                        },
                        icon: Icon(Icons.visibility),color: mainColor,)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
