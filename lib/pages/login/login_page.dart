import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'newpage.dart'; // หน้าจอเป็นแบบฝั่ง andriod

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  void _handleClickButton(int num) {
    setState(() {
      if (num == -1) {
        if (input.length > 0) input = input.substring(0, input.length - 1);
      } else {
        input = '$input$num';
        if (input.length == 6) {
          _checkpass();
        }
      }
    });
  }

  void _checkpass() {
    if (input == '123456') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homepage()),
      );
    } else {
      setState(() {
        input = '';
        _showMaterialDialog("ERROR", "Invalid PIN. Please try again.");
      });
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
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
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          // ไล่เฉดจากสีแดงไปสีน้ำเงิน
          colors: [
            Colors.white,
            Colors.blue.shade100,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Colors.grey.shade600,
                      size: 100.0,
                    ),
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Enter Pin to login',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var num = 1;
                    num <= input.length;
                    num++) // ถ้ากด สีจะขึ้นตามครั้งที่กด
                  Icon(
                    Icons.circle, // รูปไอคอน
                    size: 30.0, // ขนาดไอคอน
                    color: Colors.blue, // สีไอคอน
                  ),
                for (var j = 1;
                    j <= 6 - input.length;
                    j++) // พิมตามจำนวนที่มีทั้งหมด
                  Icon(
                    Icons.circle, // รูปไอคอน
                    size: 30.0, // ขนาดไอคอน
                    color: Colors.blue.shade100, // สีไอคอน
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                //color: Colors.pink,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2, 0, -1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2
          ? null
          : () {
              onClick(number); // {} หรือ =>
            },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: number == -2 ? null : Border.all(width: 3.0,color: Colors.black54),
        ),
        child: Center(
          child: number >= 0
              ? Text(
                  number.toString(),
                  style: Theme.of(context).textTheme.headline6,
                )
              : (number == -1
                  ? Icon(
                      Icons.backspace_outlined,
                      size: 28.0,
                    )
                  : SizedBox.shrink()),
        ),
      ),
    );
  }
}
