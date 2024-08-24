import 'package:awladsanaad_2/model/user_model.dart';
import 'package:awladsanaad_2/view/users/user_cubit.dart';
import 'package:awladsanaad_2/view/users/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom/colors.dart';
import '../../custom/data.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  
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
                    // users.add(name);
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
    // users.removeAt(id);
    // group.removeAt(id);
    // role.removeAt(id);
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
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocProvider(
  create: (context) => UserCubit()..fetchUsers(),
  child: BlocConsumer<UserCubit, UserState>(
  listener: (context, state) {
    if (state is UserFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  },
  builder: (context, state) {
    if(state is UserSuccess){
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
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: UsersWidget(users: state.users, index: index, width: widthScreen,height: heightScreen,)
                );
              },
            ),
          ),
        ),
      );
    }
    else {
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
          body: SizedBox(
            height: heightScreen,
            width: widthScreen,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  },
),
);
  }
}


class UsersWidget extends StatelessWidget {
  UsersWidget({
    super.key,
    required this.users,
    required this.index,
    required this.width,
    required this.height,
  });

  final List<UserModel> users;
  final int index;
  final double width;
  final double height;
  bool vis = Userdata["role"] == "Admin";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mainColor,
      shadowColor: mainColor,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10,bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 6.5,
                  child: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: mainColor),
                    ),
                    backgroundColor: whiteColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        users[index].name,
                        overflow:TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        users[index].userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: height/40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users[index].groups.length,
                          itemBuilder: (context, ind) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(users[index].groups[ind]!,
                                  style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),)
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width /8,
                  child: CircleAvatar(
                    backgroundColor: whiteColor,
                    child: IconButton(
                      onPressed: () {
                        // const Home()._showUpdateDialog(groups[index].id, context);
                      },
                      icon: const Icon(Icons.edit),
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
