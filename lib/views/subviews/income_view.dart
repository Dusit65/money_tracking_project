// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unused_element, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';

class IncomeView extends StatefulWidget {
  User? user;
  Money? money;

  IncomeView({super.key, this.user, this.money});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
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
                      'เงินเข้า',
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
                        labelText: 'รายการเงินเข้า',
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
                        labelText: 'จำนวนเงินเข้า',
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
                              labelText: 'วัน เดือน ปีที่เงินเข้า',
                              labelStyle: TextStyle(
                                color: Color(0xFF3E7C78),
                              ),
                              hintText: 'DATE INCOME---->',
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
                        // //Validate
                        // if (usernameCtrl.text.trim().length == 0) {
                        //   showWaringDialog(context, 'ป้อนชื่อผู้ใช้ด้วย');
                        // } else if (passwordCtrl.text.trim().length == 0) {
                        //   showWaringDialog(context, 'ป้อนรหัสผ่านด้วย');
                        // } else {
                        //   //validate username and password from DB through API
                        //   //Create a variable to store data to be sent with the API
                        //   User user = User(
                        //     username: usernameCtrl.text.trim(),
                        //     password: passwordCtrl.text.trim(),
                        //   );
                        //   //call API
                        //   CallAPI.callcheckUserPasswordAPI(user).then((value) {
                        //     if (value.message == '1') {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => HomeUI(user: value,),
                        //         ),
                        //       );
                        //     } else {
                        //       showWaringDialog(
                        //           context, "ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง");
                        //     }
                        //   });
                        // }
                      },
                      child: Text(
                        'บันทึกเงินเข้า',
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
