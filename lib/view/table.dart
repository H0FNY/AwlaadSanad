import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/colors.dart';

class table extends StatefulWidget {
  @override
  _tableState createState() => _tableState();
}

class _tableState extends State<table> {
  String mon = "";
  List<String> allData = [];
  late List<List<int?>> cellValues;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        int year = pickedDate.year;
        int month = pickedDate.month;
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

        cellValues = List.generate(
          allData.length,
          (index) => List.filled(daysOnMonth.length, 0),
        );
      });
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
    cellValues = List.generate(
      allData.length,
      (index) => List.filled(daysOnMonth.length, 0),
    );
  }

  @override
  void initState() {
    super.initState();
    getDaysInMonth();
  }

  Future<void> _loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? allDataString = prefs.getString('allData');
    if (allDataString != null) {
      allData = List<String>.from(jsonDecode(allDataString));

      cellValues = List.generate(
        allData.length,
        (index) => List.filled(31, 0),
      );

      // Load cellValues from SharedPreferences
      for (int i = 0; i < allData.length; i++) {
        List<int?>? savedRow = prefs
            .getStringList('cellValues$i')
            ?.map((str) => int.parse(str))
            .toList();
        if (savedRow != null) {
          cellValues[i] = savedRow;
        }
      }
    }
  }

  // List of colors to cycle through
  final List<Color> colors = [
    Color(0xFFFFFFFF),
    Color(0xff4caf50),
    Color(0xffffeb3b),
    Color(0xfff44336),
    Color(0xff2196f3)
  ];
  void _getNextColor(int rowIndex, int colIndex, Color currentColor) {
    int currentIndex = cellValues[rowIndex][colIndex]!;
    int nextIndex = (currentIndex + 1) % colors.length;
    cellValues[rowIndex][colIndex] = nextIndex;
  }

  void deleteStudent(int id) {
    allData.removeAt(id);
    cellValues.removeAt(id);
    setState(() {});
  }

  void addStudent(String name) {
    allData.add(name);
    cellValues = List.generate(
      allData.length,
      (index) => List.filled(daysOnMonth.length, 0),
    );
    setState(() {});
  }

  void _showAddDialog() {
    String name = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "إضافة طالب",
            textAlign: TextAlign.center,
          ),
          content: TextFormField(
            onChanged: (value) {
              name = value;
            },
          ),
          actions: [
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
                  addStudent(name);
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'لم يتم اضافة الطالب',
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

  void _showcommentDialog(int row, int col) {
    String comment = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "إضافة تعليق",
            textAlign: TextAlign.center,
          ),
          content: TextFormField(
            onChanged: (value) {
              comment = value;
            },
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text(
                "حفظ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (comment.isNotEmpty) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'لم يتم حفظ التعليق',
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

  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "هل تريد حذف الطالب ؟",
            textAlign: TextAlign.center,
          ),
          actions: [
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
          ],
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shadowColor: mainColor,
        elevation: 10,
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: whiteColor,
        ),
        title: Text(
          'حضور شهر ${mon}',
          style: const TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _pickDate,
            color: whiteColor,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
            color: whiteColor,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddDialog,
            color: whiteColor,
          ),
        ],
      ),
      body: Padding(
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
                      width: width / 2.5,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            "الاسم",
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
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
                                    _showDeleteDialog(rowIndex);
                                  },
                                  child: Text(
                                    allData[rowIndex],
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
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    column,
                                    style: const TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              ),
                            );
                          }).toList(),
                          rows: List<DataRow>.generate(
                            allData.length,
                            (rowIndex) => DataRow(
                              cells: List<DataCell>.generate(
                                cellValues[rowIndex].length,
                                (cellIndex) {
                                  final currentColor =
                                      colors[cellValues[rowIndex][cellIndex]!];
                                  return DataCell(
                                    GestureDetector(
                                      onLongPress: () {
                                        _showcommentDialog(rowIndex, cellIndex);
                                      },
                                      onTap: () {
                                        setState(() {
                                          _getNextColor(rowIndex, cellIndex,
                                              currentColor);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        color: (currentColor),
                                        child: Text(
                                          cellValues[rowIndex][cellIndex]
                                                      ?.toString() ==
                                                  "1"
                                              ? "حـ"
                                              : cellValues[rowIndex][cellIndex]
                                                          ?.toString() ==
                                                      "2"
                                                  ? "تـ"
                                                  : cellValues[rowIndex]
                                                                  [cellIndex]
                                                              ?.toString() ==
                                                          "3"
                                                      ? "غـ"
                                                      : cellValues[rowIndex][
                                                                      cellIndex]
                                                                  ?.toString() ==
                                                              "4"
                                                          ? "عـ"
                                                          : "ــ",
                                          textAlign: TextAlign.center,
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
    );
  }
}
