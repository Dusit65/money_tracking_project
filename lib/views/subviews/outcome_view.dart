// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_is_empty, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/views/home_ui.dart';
import 'package:money_tracking_project/views/subviews/main_view.dart';

class OutcomeView extends StatefulWidget {
  User? user;
  Money? money;
  OutcomeView({super.key, this.user});

  @override
  State<OutcomeView> createState() => _OutcomeViewState();
}

class _OutcomeViewState extends State<OutcomeView> {
  //TextField Controller
  TextEditingController moneyDetailCtrl = TextEditingController(text: '');
  TextEditingController moneyInOutCtrl = TextEditingController(text: '');
  TextEditingController moneyDateCtrl = TextEditingController(text: '');

  //++++++++++++++++Calendar+++++++++++++++++++++++++++++++
//Method open calendar
//variable date
  String? _DateSelected;
  Future<void> _openCalendar() async {
    final DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (_picker != null) {
      setState(() {
        moneyDateCtrl.text = convertToThaiDate(_picker);
        _DateSelected = _picker.toString().substring(0, 10);
        moneyDateCtrl.text = _picker.toString().substring(0, 10);
      });
    }
  }

//เมธอดแปลงวันที่แบบสากล (ปี ค.ศ.-เดือน ตัวเลข-วัน ตัวเลข) ให้เป็นวันที่แบบไทย (วัน เดือน ปี)
  //                             2023-11-25
  convertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }

    return day + ' ' + month + ' พ.ศ. ' + year;
  }

//++++++++++++++++Calendar+++++++++++++++++++++++++++++++

//-----------------Method showDialog-----------------------------
//Method showWaringDialog
  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//Method showCompleteDialog
  Future showCompleteDialog(context, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'ผลการทำงาน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//-----------------Method showDialog-----------------------------

//ตัวแปรเก็บข้อมูลการกินที่ได้ขากการเรียกใช้API
  Future<List<Money>>? moneyData;

  //สร้างฟังก์ชันเรียกใช้API
  getAllMoneyByuserId(Money money) {
    setState(() {
      moneyData = CallAPI.callgetAllMoneyByuserId(money);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    // bottom: ,
                    ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      color: const Color(0xFF3E7C78), // Main Color
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0),
                      )),
                ),
              ),
              //Profile
              Padding(
                padding: const EdgeInsets.only(top: 55, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 120,
                      ),
                      child: Text(
                        'Firstname Lastname',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    //Profile
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        // '${Env.hostName}/moneytrackingAPI/picupload/user/${widget.user!.userImage}',
                        'assets/images/paul.png',
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),

              //Total Money Box================================================================================
              Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                  left: 25,
                  right: 25,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      color: //const Color.fromARGB(255, 47, 116, 121), // Main Color
                          Color(0xFF107C78),
                      borderRadius: BorderRadius.circular(
                        27,
                      )),
                ),
              ),
              //Total Money Detail
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 165,
                    ),
                    child: Text(
                      'ยอดเงินคงเหลือ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //Total Money-------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: Text(
                      '2,500.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  //Text in/outcome
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 6,
                      right: 0,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 50,
                            ),
                            child: ImageIcon(
                                AssetImage(
                                  'assets/icons/income.png',
                                ),
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.height * 0.029),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 10,
                            ),
                            child: Text(
                              'ยอดเงินเข้ารวม',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 65,
                            ),
                            child: Text(
                              'ยอดเงินออกรวม',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 10,
                            ),
                            child: ImageIcon(
                                AssetImage(
                                  'assets/icons/outcome.png',
                                ),
                                color: Colors.white,
                                size:
                                    MediaQuery.of(context).size.height * 0.029),
                          ),
                        ]),
                  ),
                  //num in/outcome
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //income------------------------------------
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 55,
                            ),
                            child: Text(
                              '5,700.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          //outcome------------------------------------
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 140,
                            ),
                            child: Text(
                              '2,200.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              //===================================End of Total Money Box===============================================

              //insert Income===============================================
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 395, bottom: 50),
                    child: Text(
                      'เงินออก',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //Textfield moneyDetail
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.015,
                    ),
                    child: TextField(
                      controller: moneyDetailCtrl,
                      decoration: InputDecoration(
                        labelText: 'รายการเงินออก',
                        labelStyle: TextStyle(
                          color: Color(0xFF3E7C78),
                        ),
                        hintText: ' Detail',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3E7C78),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3E7C78),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  //Textfield moneyInOut
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.015,
                    ),
                    child: TextField(
                      controller: moneyInOutCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'จำนวนเงินออก',
                        labelStyle: TextStyle(
                          color: Color(0xFF3E7C78),
                        ),
                        hintText: ' 0.00',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3E7C78),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3E7C78),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  //TextField Birthdate
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.015,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: moneyDateCtrl,
                            readOnly: true,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'วัน เดือน ปีที่เงินออก',
                              labelStyle: TextStyle(
                                color: Color(0xFF3E7C78),
                              ),
                              hintText: 'DATE OUTCOME---->',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF3E7C78),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF3E7C78),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _openCalendar();
                                },
                                icon: ImageIcon(
                                    AssetImage(
                                      'assets/icons/calendar.png',
                                    ),
                                    color: Color(0xFF3E7C78),
                                    size: MediaQuery.of(context).size.height *
                                        0.029),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Save/Submit button
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.03,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        //Validate
                        if (moneyDetailCtrl.text.trim().length == 0) {
                          showWaringDialog(context, 'ป้อนรายการเงินออกด้วย');
                        } else if (moneyInOutCtrl.text.trim().length == 0) {
                          showWaringDialog(context, 'ป้อนจำนวนเงินออกด้วย');
                        } else if (_DateSelected == '' ||
                            _DateSelected == null) {
                          showWaringDialog(
                              context, 'เลือกวัน เดือน ปีที่เงินออกด้วย');
                        } else {
                          //validate
                          Money money = Money(
                            moneyDetail: moneyDetailCtrl.text,
                            moneyInOut: moneyInOutCtrl.text,
                            moneyDate: _DateSelected,
                          );
                          //call API
                          CallAPI.callinsertInOutComeAPI(money).then((value) {
                            if (value.message == '1') {
                              showCompleteDialog(
                                      context, 'บันทึกเงินออกสําเร็จOvO')
                                  .then((value) =>Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeUI(user: value,),
                                      ),
                                    ));
                            } else {
                              showCompleteDialog(context, 'บันทึกเงินออกไม่สําเร็จO^O');
                            }
                          });
                        }
                      },
                      child: Text(
                        'บันทึกเงินออก',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3E7C78),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.07,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
