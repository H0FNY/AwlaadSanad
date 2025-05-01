import 'dart:convert';
import 'package:awladsanaad_2/custom/custom_text_form_field.dart';
import 'package:awladsanaad_2/model/role_model.dart';
import 'package:awladsanaad_2/view/users/user_cubit.dart';
import 'package:awladsanaad_2/view/users/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom/colors.dart';
import '../../custom/data.dart';
import '../../services.dart';
import '../../model/user_model.dart';

class Users extends StatelessWidget {
  const Users({super.key});


  Future<void> _refreshData(BuildContext context) async {
    await context.read<UserCubit>().fetchUsers();
  }

  
  Future<void> _showAddDialog(BuildContext con) async {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController userUsernameController = TextEditingController();
    final TextEditingController userPasswordController = TextEditingController();

    RoleModel? selectedValue;
    final response = await RolesService().getAll();
    final List<dynamic> jsonResponse = json.decode(response.body);
    final roles = jsonResponse.map((data) => RoleModel.fromJson(data)).toList();

    showDialog(
      context: con,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: whiteColor,
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              "إضافة مستخدم",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(controller: userNameController, hintText: "الاسم"),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<RoleModel>(
                  dropdownColor: whiteColor,
                  value: selectedValue,
                  hint: const Text('اختر خياراً'),
                  items: roles.map<DropdownMenuItem<RoleModel>>((RoleModel value) {
                    return DropdownMenuItem<RoleModel>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (RoleModel? newValue) {
                    selectedValue = newValue;
                  },
                  iconDisabledColor: mainColor,
                  iconEnabledColor: mainColor,
                  style: const TextStyle(color: mainColor),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: mainColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(controller: userUsernameController, hintText: "اسم المستخدم"),
                const SizedBox(height: 16.0),
                CustomTextFormField(controller: userPasswordController, hintText: "كلمة السر"),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text(
                  "نعم",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (userNameController.text.isNotEmpty &&
                      userUsernameController.text.isNotEmpty &&
                      selectedValue != null) {
                    con.read<UserCubit>().addUser(
                      userUsernameController.text,
                      userNameController.text,
                      userPasswordController.text,
                      selectedValue!.name,
                    );
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                child: const Text(
                  "لا",
                  style: TextStyle(color: Colors.white),
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


  void _showDeleteDialog(String name, BuildContext con) {
    showDialog(
      context: con,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: whiteColor,
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              "حذف مستخدم",
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: const Text(
                  "حذف",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  con.read<UserCubit>().deleteUser(name);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
                ),
                child: const Text(
                  "لا",
                  style: TextStyle(
                    color: mainColor,
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
        listener: (context, state) async {
          if (state is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            await context.read<UserCubit>().fetchUsers();
          }
        },
        builder: (context, state) {
          if (state is UserSuccess) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  shadowColor: mainColor,
                  elevation: 10,
                  backgroundColor: mainColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: whiteColor,
                  ),
                  title: const Text(
                    'المستخدمين',
                    style: TextStyle(color: whiteColor),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: whiteColor,
                      onPressed: () => _showAddDialog(context),

                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: ()=>_refreshData(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onLongPress: (){
                              _showDeleteDialog(state.users[index].userName, context);
                            },
                            child: UsersWidget(
                              users: state.users,
                              index: index,
                              width: widthScreen,
                              height: heightScreen,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  shadowColor: mainColor,
                  elevation: 10,
                  backgroundColor: mainColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: whiteColor,
                  ),
                  title: const Text(
                    'المستخدمين',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
                body: const Center(child: CircularProgressIndicator()),
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
                    backgroundColor: whiteColor,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: mainColor),
                    ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        users[index].role,
                        overflow:TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: height/26,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users[index].groups.length,
                          itemBuilder: (context, ind) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                child: Center(
                                  child: Text(users[index].groups[ind]!,
                                    style: const TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),),
                                ),
                              ),
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
                        // const Users()._showUpdateDialog(groups[index].id, context);
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