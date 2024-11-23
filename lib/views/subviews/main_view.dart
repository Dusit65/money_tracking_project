// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, use_full_hex_values_for_flutter_colors, must_be_immutable, annotate_overrides, avoid_print
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/message_format.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/utils/env.dart';

class MainView extends StatefulWidget {
  User? user;
  Money? money;

  MainView({super.key, this.user, this.money});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  //ตัวแปรเก็บข้อมูลการกินที่ได้ขากการเรียกใช้API
  Future<List<Money>>? moneyData;

  //สร้างฟังก์ชันเรียกใช้API
  getAllMoneyByuserId(Money money) {
    setState(() {
      moneyData = CallAPI.callgetAllMoneyByuserId(money);
    });
  }

  @override
  void initState() {
    // ตรวจสอบว่ามีข้อมูล User หรือไม่ก่อนเรียก API
//ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR vv
    Money money = Money(userId: widget.user!.userId);
    getAllMoneyByuserId(money);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                    left: 10,
                    right: 100,
                  ),
                  child: Text(
                    '${widget.user!.userFullName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                //Profile
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${Env.hostName}/moneytrackingAPI/picupload/user/${widget.user!.userImage}',
                    // 'assets/images/paul.png',
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                        size: MediaQuery.of(context).size.height * 0.029),
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
                        size: MediaQuery.of(context).size.height * 0.029),
                  ),
                ]),
              ),
              //num in/outcome
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 395, bottom: 50),
                child: Text(
                  'เงินเข้า/เงินออก',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
//Income/Outcome List=============================================================================
              Expanded(
                child: FutureBuilder<List<Money>>(
                  future: moneyData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data![0].message == "0") {
                        return Text("ยังไม่ได้บันทึกรายการ");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var moneyItem = snapshot.data![index];
                              return Column(children: [
                                ListTile(
                                  onTap: () {},
                                  tileColor: moneyItem.moneyType == "1"
                                      ? Colors.green[50]
                                      : Colors.red[50],
                                  leading: Icon(
                                    moneyItem.moneyType == "1"
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color: moneyItem.moneyType == "1"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  title: Text(
                                    snapshot.data![index].moneyDetail!,
                                  ),
                                  subtitle: Text(
                                    'วันที่บันทึก : ${snapshot.data![index].moneyDate}',
                                  ),
                                  trailing:
                                      Text(snapshot.data![index].moneyInOut!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: moneyItem.moneyType == "1"
                                                ? Colors.green
                                                : Colors.red,
                                          )),
                                ),
                                // Divider(),
                              ]);
                            });
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
