import 'package:awladsanaad_2/custom/custom_text_form_field.dart';
import 'package:awladsanaad_2/model/student_model.dart';
import 'package:awladsanaad_2/view/search/search_student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../custom/colors.dart';

class SearchStudent extends StatefulWidget {
  SearchStudent();
  @override
  _SearchStudentState createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  String mon = "";
  List<SearchStudentModel> allData = [];
  late List<List<MapEntry>> cellValues;
  DateTime? pickedDate = DateTime.now();
  String month ="";
  Future<void> _pickDate(BuildContext con) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        int year = pickedDate!.year;
        int month = pickedDate!.month;
        if (month == 1)
          mon = "يناير";
        else if (month == 2)
          mon = "فبراير";
        else if (month == 3)
          mon = "مارس";
        else if (month == 4)
          mon = "ابريل";
        else if (month == 5)
          mon = "مايو";
        else if (month == 6)
          mon = "يونيو";
        else if (month == 7)
          mon = "يوليو";
        else if (month == 8)
          mon = "اغسطس";
        else if (month == 9)
          mon = "سبتمبر";
        else if (month == 10)
          mon = "اكتوبر";
        else if (month == 11)
          mon = "نوفمبر";
        else if (month == 12) mon = "ديسمبر";

        DateTime firstDayOfMonth = DateTime(year, month, 1);
        DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
        daysOnMonth.clear();
        for (int i = 0; i < lastDayOfMonth.day; i++) {
          DateTime day = firstDayOfMonth.add(Duration(days: i));
          String s = DateFormat('dd\nE').format(day);
          String ara = "";
          if (s.substring(3) == "Sat")
            ara = s.substring(0, 2) + "\nالسبت";
          else if (s.substring(3) == "Sun")
            ara = s.substring(0, 2) + "\nالاحد";
          else if (s.substring(3) == "Mon")
            ara = s.substring(0, 2) + "\nالاثنين";
          else if (s.substring(3) == "Tue")
            ara = s.substring(0, 2) + "\nالثلاثاء";
          else if (s.substring(3) == "Wed")
            ara = s.substring(0, 2) + "\nالاربعاء";
          else if (s.substring(3) == "Thu")
            ara = s.substring(0, 2) + "\nالخميس";
          else if (s.substring(3) == "Fri")
            ara = s.substring(0, 2) + "\nالجمعة";
          daysOnMonth.add(ara);
        }
      });
      month = pickedDate.toString().substring(0,7).split("-").reversed.join("-");
      await con.read<SearchStudentCubit>().fetchAllAttendance(month,daysOnMonth.length);
    }
  }

  List<String> daysOnMonth = [];
  void getDaysInMonth() {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    if (month == 1)
      mon = "يناير";
    else if (month == 2)
      mon = "فبراير";
    else if (month == 3)
      mon = "مارس";
    else if (month == 4)
      mon = "ابريل";
    else if (month == 5)
      mon = "مايو";
    else if (month == 6)
      mon = "يونيو";
    else if (month == 7)
      mon = "يوليو";
    else if (month == 8)
      mon = "اغسطس";
    else if (month == 9)
      mon = "سبتمبر";
    else if (month == 10)
      mon = "اكتوبر";
    else if (month == 11)
      mon = "نوفمبر";
    else if (month == 12) mon = "ديسمبر";

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    daysOnMonth.clear();
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      String s = DateFormat('dd\nE').format(day);
      String ara = "";
      if (s.substring(3) == "Sat")
        ara = s.substring(0, 2) + "\nالسبت";
      else if (s.substring(3) == "Sun")
        ara = s.substring(0, 2) + "\nالاحد";
      else if (s.substring(3) == "Mon")
        ara = s.substring(0, 2) + "\nالاثنين";
      else if (s.substring(3) == "Tue")
        ara = s.substring(0, 2) + "\nالثلاثاء";
      else if (s.substring(3) == "Wed")
        ara = s.substring(0, 2) + "\nالاربعاء";
      else if (s.substring(3) == "Thu")
        ara = s.substring(0, 2) + "\nالخميس";
      else if (s.substring(3) == "Fri") ara = s.substring(0, 2) + "\nالجمعة";
      daysOnMonth.add(ara);
    }
  }

  @override
  void initState() {
    super.initState();
    getDaysInMonth();
    month = pickedDate.toString().substring(0,7).split("-").reversed.join("-");
  }

  final List<Color> colors = [
    const Color(0xFFFFFFFF),
    const Color(0xff4caf50),
    const Color(0xffffeb3b),
    const Color(0xfff44336),
    const Color(0xff2196f3)
  ];
  void _getNextColor(int rowIndex, int colIndex, Color currentColor) {
    int currentIndex = cellValues[rowIndex][colIndex].value!;
    int nextIndex = (currentIndex + 1) % colors.length;
    cellValues[rowIndex][colIndex] = MapEntry(cellValues[rowIndex][colIndex].key, nextIndex);
  }

  Future<void> _refreshData(BuildContext context) async {
    await context.read<SearchStudentCubit>().fetchAllAttendance(month,daysOnMonth.length);
  }
  void _showSearchDialog(BuildContext con) {
    final TextEditingController groupNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            "إبحث",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
            ),
          ),
          content: CustomTextFormField(
            controller: groupNameController,
            hintText: "اسم الطالب",
          ),
          actions: [
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
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              ),
              child: const Text(
                "نعم",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (groupNameController.text.isNotEmpty) {
                  con.read<SearchStudentCubit>().fetchStudentsByName(groupNameController.text, month,daysOnMonth.length);
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'لا يوجد طالب بهذا الاسم',
                      textAlign: TextAlign.end,
                    ),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(int id,BuildContext con) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            "هل تريد حذف الطالب ؟",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
            ),
          ),
          actions: [
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
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              ),
              child: const Text(
                "نعم",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                con.read<SearchStudentCubit>().deactivate(id, month,daysOnMonth.length);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SearchStudentCubit()..fetchAllAttendance(month,daysOnMonth.length),
      child: BlocConsumer<SearchStudentCubit, SearchStudentState>(
        listener: (context, state) async {
          if (state is SearchStudentSuccess) {
            allData=state.students;
            cellValues=state.cellValues;
            setState(() {

            });
          }
          if (state is SearchStudentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            await context
                .read<SearchStudentCubit>()
                .fetchAllAttendance( month,daysOnMonth.length);
          }
        },
        builder: (context, state) {
          if (state is SearchStudentSuccess) {
            return Scaffold(
              backgroundColor: whiteColor,
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
                title: Text(
                  'حضور شهر ${mon}',
                  style:  TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenW/20
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: (){
                      _pickDate(context);
                    },
                    color: whiteColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _showSearchDialog(context);
                    },
                    color: whiteColor,
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () => _refreshData(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: [
                              // Fixed column for names
                              SizedBox(
                                width: screenW / 2.4,
                                child: DataTable(
                                  columns:  [
                                    DataColumn(
                                        label: Expanded(
                                            child: Text(
                                              "الاسم",
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenW/25
                                              ),
                                            )))
                                  ],
                                  rows: List<DataRow>.generate(
                                    allData.length,
                                        (rowIndex) => DataRow(
                                      cells: [
                                        DataCell(
                                          GestureDetector(
                                            onLongPress: () {
                                              _showDeleteDialog(allData[rowIndex].id,context);
                                            },
                                            child: Text(
                                              allData[rowIndex].name,
                                              style: TextStyle(
                                                  fontSize: screenW/32,
                                                  fontWeight: FontWeight.bold,
                                                  color: mainColor
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Scrollable section for remaining columns
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: 7,
                                    columns: daysOnMonth.map((column) {
                                      return DataColumn(
                                        label: Expanded(
                                          child: Center(
                                              child: Text(
                                                column,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenW/30
                                                ),
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      );
                                    }).toList(),
                                    rows: List<DataRow>.generate(
                                      allData.length,
                                          (rowIndex) => DataRow(
                                        cells: List<DataCell>.generate(
                                          cellValues[rowIndex].length,
                                              (cellIndex) {
                                            final currentColor = colors[
                                            cellValues[rowIndex][cellIndex].value!];
                                            return DataCell(
                                              GestureDetector(
                                                onLongPress: () {
                                                  // _showcommentDialog(
                                                  //     rowIndex, cellIndex);
                                                },
                                                onTap: () {
                                                  setState(() {
                                                    _getNextColor(rowIndex,
                                                        cellIndex, currentColor);
                                                  });
                                                },
                                                child: Container(
                                                  width: screenW/9,
                                                  height: screenH/22,
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 15,),
                                                  color: (currentColor),
                                                  child: Center(
                                                    child: Text(
                                                      cellValues[rowIndex]
                                                      [cellIndex].value
                                                          ?.toString() ==
                                                          "1"
                                                          ? "حـ"
                                                          : cellValues[rowIndex][
                                                      cellIndex].value
                                                          ?.toString() ==
                                                          "2"
                                                          ? "تـ"
                                                          : cellValues[rowIndex]
                                                      [
                                                      cellIndex].value
                                                          ?.toString() ==
                                                          "3"
                                                          ? "غـ"
                                                          : cellValues[rowIndex]
                                                      [
                                                      cellIndex].value
                                                          ?.toString() ==
                                                          "4"
                                                          ? "عـ"
                                                          : "ــ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: screenW/30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: whiteColor,
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
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
