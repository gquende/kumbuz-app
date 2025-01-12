import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/theme/styles.dart';

import '../../../../helper/global.dart';
import '../controllers/chat_controller.dart';
import '../widgets/message_card.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final chatController = ChatController();
  var isDefaultDequestion = false.obs;
  String defaultQuestion = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    mq = MediaQuery.of(context).size;
    return Scaffold(
        //app bar
        appBar: AppBar(
          title: Image(image: AssetImage("assets/images/ai_logo.png")),
        ),

        //send message field & btn
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !isDefaultDequestion.value
                      ? SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultQuestion(
                                        "O que são finanças pessoais?"),
                                    DefaultQuestion(
                                        "Como posso melhorar as minhas finanças pessoais?")
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultQuestion(
                                        "Quais são os principais componentes de um orçamento financeiro pessoal?"),
                                    DefaultQuestion(
                                        "Como eu posso começar a economizar e investir de forma eficaz?")
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    //text input field
                    Expanded(
                        child: TextFormField(
                      controller: chatController.textEdintingController,
                      textAlign: TextAlign.center,
                      onTapOutside: (e) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          filled: true,
                          isDense: true,
                          hintText: 'Me pergunte tudo sobre finanças...',
                          hintStyle: const TextStyle(fontSize: 14),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                    )),

                    const SizedBox(width: 8),

                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () {
                          chatController.askQuestion(
                              chatController.textEdintingController.text);
                        },
                        icon: const Icon(Icons.send,
                            color: Colors.white, size: 28),
                      ),
                    )
                  ]),
                ],
              );
            })),

        //body
        body: Stack(
          children: [
            Obx(
              () => ListView(
                physics: const BouncingScrollPhysics(),
                controller: chatController.scrollController,
                padding: EdgeInsets.only(
                    top: size.height * .02, bottom: size.height * .1),
                children: chatController.list
                    .map((e) => MessageCard(message: e))
                    .toList(),
              ),
            ),
            // Positioned(
            //     top: size.height * 0.70,
            //     // left: size.width * 0.05,
            //     child: SingleChildScrollView(
            //       child: Container(
            //         width: size.width,
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   DefaultQuestion(
            //                       "Como melhorar as minhas finanças"),
            //                   DefaultQuestion(
            //                       "Como melhorar as minhas finanças")
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   DefaultQuestion(
            //                       "Como melhorar as minhas finanças"),
            //                   DefaultQuestion(
            //                       "Como melhorar as minhas finanças")
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ))
          ],
        ));
  }

  Widget DefaultQuestion(String question) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        defaultQuestion = question;
        isDefaultDequestion.value = true;
        chatController.askQuestion(question);
      },
      child: Container(
        width: size.width * 0.45,
        height: 62,
        decoration: AppStyles.containerDecoration(context),
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: Text(question),
      ),
    );
  }
}
