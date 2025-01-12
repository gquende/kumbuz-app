import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kumbuz/features/sateva/presenter/pages/expense/controller/expense_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/goals/controller/goal_controller.dart';
import 'package:kumbuz/shared/presentation/ui/spacing.dart';

class CreateGoal extends StatefulWidget {
  const CreateGoal({super.key});

  @override
  State<CreateGoal> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final GoalController _controller = GoalController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Criar Objectivo",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.38,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Positioned(
                    top: size.height * 0.07,
                    left: size.width * 0.1,
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.45,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, top: 30),
                          child: Form(
                            key: _controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacing.y(),
                                Text("Nome do objectivo"),
                                Spacing.y(),
                                Container(
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xffe5e5e5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      controller:
                                          _controller.nameFieldController,
                                      decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.description_outlined),
                                          hintText: "",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          focusColor: Color(0xff000000),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(11))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(11))),
                                          fillColor: Color(0xffe5e5e5),
                                          labelStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                const Spacing.y(),
                                const Text("Valor"),
                                const Spacing.y(),
                                Container(
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xffe5e5e5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _controller.amountController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.monetization_on_outlined),
                                          hintText: "",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          focusColor: Color(0xff000000),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(11))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(11))),
                                          fillColor: Color(0xffe5e5e5),
                                          labelStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Spacing.y(),
                                Text("Data"),
                                Spacing.y(),
                                GestureDetector(
                                  onTap: () async {
                                    await _controller.seleccionarData(context);
                                  },
                                  child: Container(
                                    width: size.width,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe5e5e5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Obx(() {
                                          return TextField(
                                            readOnly: true,
                                            controller: _controller
                                                .dateController.value,
                                            decoration: InputDecoration(
                                                prefixIcon: GestureDetector(
                                                    onTap: () async {
                                                      await _controller
                                                          .seleccionarData(
                                                              context);
                                                    },
                                                    child: const Icon(
                                                        Icons.date_range)),
                                                hintText: "",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 10),
                                                focusColor:
                                                    const Color(0xff000000),
                                                filled: true,
                                                enabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(11))),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    11))),
                                                fillColor:
                                                    const Color(0xffe5e5e5),
                                                labelStyle: const TextStyle(
                                                    color: Color(0xff000000)),
                                                border:
                                                    const OutlineInputBorder()),
                                            onTap: () async {
                                              await _controller
                                                  .seleccionarData(context);
                                            },
                                          );
                                        })),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
                Positioned(
                  top: size.height * 0.8,
                  left: size.width * 0.10,
                  child: GestureDetector(
                    onTap: () async {
                      await _controller.createGoal(context);
                    },
                    child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Obx(() {
                          return _controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  "Criar",
                                  style: TextStyle(color: Colors.white),
                                );
                        })),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
