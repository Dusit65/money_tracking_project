// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, use_full_hex_values_for_flutter_colors, must_be_immutable
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
    Money money = Money(
      userId: widget.user!.userId,
    );
    getAllMoneyByuserId(money);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 80,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.33,
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
            padding: const EdgeInsets.only(top: 0, bottom: 230),
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
                  child: Image.network(
                    '${Env.hostName}/moneytrackingAPI/picupload/user/${widget.user!.userImage}',
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
          //total money
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
              left: 35,
              right: 35,
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
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
            ),
            child: Text(
              'ยอดเงินคงเหลือ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 65,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
                  left: 50,
                ),
                child: ImageIcon(
                    AssetImage(
                      'assets/icons/income.png',
                    ),
                    size: MediaQuery.of(context).size.height * 0.029),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
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
                  top: 200,
                  left: 70,
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
                  top: 200,
                  left:10,
                ),
                child: ImageIcon(
                    AssetImage(
                      'assets/icons/outcome.png',
                    ),
                    size: MediaQuery.of(context).size.height * 0.029),
              ),
            ]),
          ),
          //num in/outcome
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              
              Padding(
                padding: const EdgeInsets.only(
                  top: 300,
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
               Padding(
                padding: const EdgeInsets.only(
                  top: 300,
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
    );
  }
}
