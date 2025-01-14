import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app.dart';
import '../../../../core/services/ia_api.dart';
import '../../../../helper/my_dialog.dart';
import '../../domain/entitites/message.dart';

class ChatController extends GetxController {
  final textEdintingController = TextEditingController();

  final scrollController = ScrollController();

  final list = <Message>[
    Message(
        msg: 'Olá ${App.user?.name}, como posso ajudar com suas finanças?',
        msgType: MessageType.bot)
  ].obs;

  Future<void> askQuestion(String question) async {
    var response = "";
    try {
      if (question.trim().isNotEmpty) {
        //user
        list.add(Message(msg: question, msgType: MessageType.user));
        list.add(Message(msg: '', msgType: MessageType.bot));
        _scrollDown();
//String test12="12*123";

//test12.interpret();

        var newQuestion = question + ". Responde com no máximo 150 palavras";
        var res = await APIs.getAnswer(newQuestion);
        //var res = await APIs.getAnswerGPT(question);
        response = res;
        List<int> bytes = latin1.encode(res);
        res = utf8.decode(bytes);

        list.removeLast();
        list.add(Message(msg: res, msgType: MessageType.bot));
        _scrollDown();

        textEdintingController.text = '';
      } else {
        MyDialog.info('Pergunte alguma coisa sobre finanças pessoais...!');
      }
    } catch (error) {
      if (error is FormatException) {
        list.removeLast();
        list.add(Message(msg: response, msgType: MessageType.bot));
        _scrollDown();

        textEdintingController.text = '';
      }
    }
  }

  //for moving to end message
  void _scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
