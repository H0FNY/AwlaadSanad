import 'dart:convert';
import 'package:awladsanaad_2/custom/custom_text_form_field.dart';
import 'package:awladsanaad_2/view/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom/colors.dart';
import '../../custom/data.dart';
import '../../model/group_model.dart';
import '../../model/user_model.dart';
import '../../services.dart';
import '../../test.dart';
import '../settings.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _refreshData(BuildContext context) async {
    await context.read<HomeCubit>().fetchGroups();
  }

  void _showAddDialog(BuildContext con) async {
    final TextEditingController groupNameController = TextEditingController();
    UserModel? selectedValue;
    final response = await UsersService().getAll();
    final List<dynamic> jsonResponse = json.decode(response.body);
    final users = jsonResponse.map((data) => UserModel.fromJson(data)).toList();

    showDialog(
      context: con,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: whiteColor,
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              "إضافة مجموعة",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: groupNameController,
                  hintText: "اسم المجموعة",
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<UserModel>(
                  dropdownColor: whiteColor,
                  value: selectedValue,
                  hint: const Text('اختر خياراً'),
                  items:
                      users.map<DropdownMenuItem<UserModel>>((UserModel value) {
                    return DropdownMenuItem<UserModel>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (UserModel? newValue) {
                    selectedValue = newValue;
                  },
                  iconDisabledColor: mainColor,
                  iconEnabledColor: mainColor,
                  style: TextStyle(color: mainColor),
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
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: const Text(
                  "حفظ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (groupNameController.text.isNotEmpty &&
                      selectedValue != null) {
                    con
                        .read<HomeCubit>()
                        .addGroup(groupNameController.text, selectedValue!);
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

  void _showDeleteDialog(int id, BuildContext con) {
    showDialog(
      context: con,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: whiteColor,
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              "حذف المجموعة",
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
                  con.read<HomeCubit>().deleteGroup(id);
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

  void _showUpdateDialog(int id, BuildContext con) async {
    final TextEditingController groupNameController = TextEditingController();
    UserModel? selectedValue;
    final response = await UsersService().getAll();
    final List<dynamic> jsonResponse = json.decode(response.body);
    final users = jsonResponse.map((data) => UserModel.fromJson(data)).toList();

    showDialog(
      context: con,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: whiteColor,
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              "تعديل المجموعة",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: groupNameController,
                  hintText: "اسم المجموعة",
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: selectedValue,
                  hint: const Text('اختر خياراً'),
                  items:
                      users.map<DropdownMenuItem<UserModel>>((UserModel value) {
                    return DropdownMenuItem<UserModel>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (UserModel? newValue) {
                    selectedValue = newValue;
                  },
                  iconDisabledColor: mainColor,
                  iconEnabledColor: mainColor,
                  style: TextStyle(color: mainColor),
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
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: const Text(
                  "تعديل",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print(groupNameController.text);
                  if (groupNameController.text.isNotEmpty || selectedValue!=null) {
                      con.read<HomeCubit>().updateGroup(id, groupNameController.text, selectedValue);
                    Navigator.of(context).pop();
                  } else {

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'لم يتم تعديل المجموعة',
                        textAlign: TextAlign.end,
                      ),
                    ));
                  }
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
      create: (context) => HomeCubit()..fetchGroups(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: whiteColor,
                appBar: AppBar(
                  shadowColor: mainColor,
                  elevation: 10,
                  backgroundColor: mainColor,
                  title: const Text(
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
                          MaterialPageRoute(
                              builder: (context) => const Settings()),
                        );
                      },
                      icon: const Icon(Icons.settings),
                      color: whiteColor,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const testt()));
                      },
                      icon: const Icon(Icons.g_translate),
                      color: whiteColor,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: whiteColor,
                      onPressed: () {
                        _showAddDialog(context);
                      },
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 12, top: 20),
                    child: ListView.builder(
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            _showDeleteDialog(state.groups[index].id, context);
                          },
                          child: GroupWidget(
                            width: widthScreen,
                            groups: state.groups,
                            index: index,
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
                backgroundColor: whiteColor,
                appBar: AppBar(
                  shadowColor: mainColor,
                  elevation: 10,
                  backgroundColor: mainColor,
                  title: const Text(
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
                          MaterialPageRoute(
                              builder: (context) => const Settings()),
                        );
                      },
                      icon: const Icon(Icons.settings),
                      color: whiteColor,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const testt()));
                      },
                      icon: const Icon(Icons.g_translate),
                      color: whiteColor,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: whiteColor,
                      onPressed: () async {
                        _showAddDialog(context);
                      },
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  child: SizedBox(
                    height: heightScreen,
                    width: widthScreen,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class GroupWidget extends StatelessWidget {
  GroupWidget({
    super.key,
    required this.groups,
    required this.index,
    required this.width,
  });

  final List<Group> groups;
  final int index;
  final double width;
  bool vis = Userdata["role"] == "Admin";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mainColor,
      shadowColor: mainColor,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
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
                        groups[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        groups[index].teacherName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        groups[index].studentsCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      vis
                          ? CircleAvatar(
                              backgroundColor: whiteColor,
                              child: IconButton(
                                onPressed: () {
                                  const Home()._showUpdateDialog(
                                      groups[index].id, context);
                                },
                                icon: const Icon(Icons.edit),
                                color: mainColor,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: table(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.visibility),
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
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
