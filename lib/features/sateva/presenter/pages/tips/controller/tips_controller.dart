import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kumbuz/features/sateva/domain/entities/tips.dart';

import '../../../../../../services/ia_api.dart';
import '../widget/tips_dialog.dart';

class TipsController {
  Future<String?> getTips() async {
    String response = "";
    try {
      var res = await APIs.getAnswer(
          "Dê uma dica aleatória do dia em pt-pt sobre finanças pessoais usando no máximo 70 palavras e se for a usar moeda use Kzs");

      //var res = await APIs.getAnswerGPT(question);
      response = res;
      List<int> bytes = latin1.encode(res);
      res = utf8.decode(bytes);
    } catch (error) {
      if (error is FormatException) {
        if (response.isNotEmpty) {
          Tips novo = Tips(title: "Dica rápida", message: response);
        }
      }
    }
    return response;
  }

  Future<void> showDayTips(BuildContext context) async {
    String response = "";
    try {
      var res = await APIs.getAnswer(
          "Dê uma dica aleatória do dia em pt-pt sobre finanças pessoais usando no máximo 70 palavras e se for a usar moeda use a AOA ou Kzs");

      //var res = await APIs.getAnswerGPT(question);
      response = res;
      List<int> bytes = latin1.encode(res);
      res = utf8.decode(bytes);

      if (res.isNotEmpty) {
        Tips novo = Tips(title: "Dica rápida", message: response);
        tipsDialog(context, novo);
      }
    } catch (error) {
      if (error is FormatException) {
        if (response.isNotEmpty) {
          Tips novo = Tips(title: "Dica rápida", message: response);

          tipsDialog(context, novo);
        }
      }
    }
  }

  Future<void> showPersonalTips(BuildContext context) async {
    String response = "";
    try {
      // var res = await APIs.getAnswer(
      //     "Dê uma dica aleatória de finanças pessoais usando no máximo 50 palavras em pt-pt");
      //
      // //var res = await APIs.getAnswerGPT(question);
      // response = res;
      // List<int> bytes = latin1.encode(res);
      // res = utf8.decode(bytes);

      Tips novo = Tips(
          title: "Dicas",
          message:
              "Dicas Rápidas para suas Finanças Pessoais Em até 50 palavras, aqui vão algumas dicas: Controle seus gastos: Use aplicativos ou planilhas para acompanhar suas entradas e saídas. Estabeleça metas: Defina objetivos financeiros e crie um plano para alcançá-los. Poupe para o futuro: Separe uma quantia mensal para imprevistos e investimentos. Evite dívidas: Priorize o pagamento de dívidas e use o cartão de crédito com moderação. Invista seu dinheiro: Faça seu dinheiro trabalhar para você. Consulte um especialista. Gostaria de dicas mais específicas? Podemos explorar temas como como montar um orçamento, negociar dívidas ou investir para a aposentadoria.");
      tipsDialog(context, novo);
      // if (res.isNotEmpty) {
      //   Tips novo = Tips(type: "tips", message: response);
      //
      //
      // }
    } catch (error) {
      if (error is FormatException) {
        if (response.isNotEmpty) {
          Tips novo = Tips(title: "tips", message: response);

          tipsDialog(context, novo);
        }
      }
    }
  }
}
