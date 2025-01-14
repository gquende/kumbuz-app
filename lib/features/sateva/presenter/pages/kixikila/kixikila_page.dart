import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/controller/kixikila_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/widgets/kixikila_card_widget.dart';

import '../../../../../app.dart';
import 'add_kixikila/kixikila_form2.dart';

class KixikilaPage extends StatefulWidget {
  const KixikilaPage({super.key});

  @override
  State<KixikilaPage> createState() => _KixikilaPageState();
}

class _KixikilaPageState extends State<KixikilaPage> {
  KixikilaController controller = DI.get<KixikilaController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kixikila"),
        elevation: 3,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: controller.kixikilas.length > 0
                ? Column(
                    children: controller.kixikilas.map((data) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: KixikilaCardWidget(kixikila: data),
                      );
                    }).toList(),
                  )
                : Container(
                    height: size.height * 0.7,
                    child: Center(
                      child: Text("Sem kixikilas!"),
                    ),
                  ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            print("User");
            print(App.user?.uuId);

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const KixikilaForm2()));

            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const CustomTags()));
          }),
    );
  }
}
