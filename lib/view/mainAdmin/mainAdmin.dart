import 'package:awladsanaad_2/custom/colors.dart';
import 'package:awladsanaad_2/view/deactive/deactivated_screen.dart';
import 'package:awladsanaad_2/view/home/Home.dart';
import 'package:awladsanaad_2/view/search/searchScreen.dart';
import 'package:flutter/material.dart';

import '../users/users.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
          child: Column(
            children: [
              SizedBox(height: screenH / 5),
              Image.asset(
                "assets/images/school.png",
                width: screenW / 2,
              ),
              SizedBox(
                height: screenH / 25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Users()),
                          );
                        },
                        child: Card(
                          color: mainColor,
                          child: SizedBox(
                            height: screenH / 5.5,
                            width: screenW / 2.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: screenW / 6,
                                  color: whiteColor,
                                ),
                                Text(
                                  "المستخدمين",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenW / 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Card(
                          color: mainColor,
                          child: SizedBox(
                            height: screenH / 5.5,
                            width: screenW / 2.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.groups,
                                  size: screenW / 6,
                                  color: whiteColor,
                                ),
                                Text(
                                  "المجموعات",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenW / 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(textDirection: TextDirection.rtl,child: DeactivatedStudents())),
                          );
                        },
                        child: Card(
                          color: mainColor,
                          child: SizedBox(
                            height: screenH / 5.5,
                            width: screenW / 2.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.block,
                                  size: screenW / 6,
                                  color: whiteColor,
                                ),
                                Text(
                                  "المنقطعين",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenW / 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(textDirection: TextDirection.rtl,
                                    child: SearchStudent())),
                          );
                        },
                        child: Card(
                          color: mainColor,
                          child: SizedBox(
                            height: screenH / 5.5,
                            width: screenW / 2.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: screenW / 6,
                                  color: whiteColor,
                                ),
                                Text(
                                  "بحث",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenW / 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                          color: mainColor,
                          child: SizedBox(
                            height: screenH / 5.5,
                            width: screenW / 2.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.supervised_user_circle,
                                  size: screenW / 6,
                                  color: whiteColor,
                                ),
                                Text(
                                  "الوظائف",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenW / 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
