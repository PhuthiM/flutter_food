import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUTTER FOOD"),
      ),
      body: Center(
        child: Container(
          child: Text('THIS IS A HOME PAGE',style: Theme.of(context).textTheme.headline1,),
        ),
      ),
    );
  }
}
