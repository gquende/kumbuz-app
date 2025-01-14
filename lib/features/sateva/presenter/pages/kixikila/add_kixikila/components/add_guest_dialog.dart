import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/controller/kixikila_controller.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../../../../shared/presentation/ui/spacing.dart';

Future<void> addGuestDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  var isLoading = false.obs;

  var controller = DI.get<KixikilaController>();

  double _distanceToField = size.width;

  //Todo create a Instance of TagController
  var stringTagController = MyStringTagController(context);

  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Text("Nome de utilizador"),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextFieldTags<String>(
                              textfieldTagsController: stringTagController,
                              initialTags: controller.guestsOfKixikila,
                              textSeparators: const [' ', ','],
                              letterCase: LetterCase.normal,
                              validator: (String tag) {
                                if (tag.length < 5) {
                                  return 'Insira um utilizador válido';
                                }
                                return null;
                              },
                              inputFieldBuilder: (context, inputFieldValues) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: TextField(
                                    controller:
                                        inputFieldValues.textEditingController,
                                    focusNode: inputFieldValues.focusNode,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      helperText: '',
                                      helperStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      hintText: inputFieldValues.tags.isNotEmpty
                                          ? ''
                                          : "Nome de Utilizadores...",
                                      errorText: inputFieldValues.error,
                                      prefixIconConstraints: BoxConstraints(
                                          maxWidth: _distanceToField * 0.74),
                                      prefixIcon: inputFieldValues
                                              .tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: inputFieldValues
                                                  .tagScrollController,
                                              scrollDirection: Axis.vertical,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 8,
                                                ),
                                                child: Wrap(
                                                    runSpacing: 4.0,
                                                    spacing: 4.0,
                                                    children: inputFieldValues
                                                        .tags
                                                        .map((String guest) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                20.0),
                                                          ),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: Colors
                                                                          .white),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    '$guest',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                //print("$tag selected");
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                width: 4.0),
                                                            InkWell(
                                                              child: const Icon(
                                                                Icons.cancel,
                                                                size: 14.0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        233,
                                                                        233,
                                                                        233),
                                                              ),
                                                              onTap: () {
                                                                inputFieldValues
                                                                    .onTagRemoved(
                                                                        guest);

                                                                controller
                                                                    .removeGuest(
                                                                        guest);
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }).toList()),
                                              ),
                                            )
                                          : null,
                                    ),
                                    onSubmitted: (value) {
                                      try {
                                        inputFieldValues.onTagSubmitted(value);
                                      } on FormatException catch (_) {
                                        stringTagController.setError =
                                            "Deves inserir um user válido";
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacing.y(),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          GestureDetector(
                            onTap: () async {
                              isLoading.value = true;

                              // await controller.invitingUser(
                              //     usernameTEController.text, context);

                              Navigator.of(context).pop();

                              isLoading.value = false;
                            },
                            child: Container(
                                width: size.width,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 0),
                                          color: Colors.black12,
                                          spreadRadius: .7,
                                          blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Obx(() {
                                  return Center(
                                    child: isLoading.value
                                        ? const CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          )
                                        : const Text(
                                            "Fechar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  );
                                })),
                          ),
                        ],
                      ))),
            ),
          ),
        );
      },
      barrierDismissible: !isLoading.value);

  return;
}

class MyStringTagController<T extends String>
    extends TextfieldTagsController<T> {
  BuildContext context;

  MyStringTagController(this.context);

  var controller = DI.get<KixikilaController>();

  @override
  bool? onTagSubmitted(T tag) {
    String? validate = getValidator != null ? getValidator!(tag) : null;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    if (validate == null && tag.length > 5) {
      bool? addTag = super.addTag(tag);

      if (addTag == true) {
        controller.invitingUser(tag, context);

        setError = null;
        scrollTags();
      }
    } else if (validate != null) {
      super.setError = validate;
    } else {
      super.setError = 'Insira um número válido';
    }
    notifyListeners();
    return null;
  }

  @override
  set setError(String? error) {
    super.setError = error;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    notifyListeners();
  }
}
