import 'package:flutter/material.dart';

import 'base/pages/root_app.dart';
// import 'package:kumbuz/services/nordigen_service.dart';

class MockWidgetsTest extends StatelessWidget {
  const MockWidgetsTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor: Colors.blue,
        // appBar: AppBar(
        //   title: Text("MockWidgets Test"),
        // ),
        //body: NewBudget());

        body: RootApp());
  }
}
