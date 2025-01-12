import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/services/mhadia_service.dart';
import 'package:kumbuz/features/sateva/data/models/question.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/widget/button.dart';
import 'package:lottie/lottie.dart';

// import 'package:kumbuz/services/mhadia_service.dart';

import '../../../../app.dart';
import 'base/pages/root_app.dart';

class PerfilAnalysis extends StatefulWidget {
  static Map<int, int> responseOfQuestion = Map<int, int>();
  static int currentPage = 0;
  static int numberOfPages = 0;
  static PageController questionPageViewController = PageController();
  static String perfilSelected = '';

  const PerfilAnalysis({Key? key}) : super(key: key);

  @override
  _PerfilAnalysisState createState() => _PerfilAnalysisState();
}

class _PerfilAnalysisState extends State<PerfilAnalysis> {
  // int page = 0;
  List<Object> pages = [];
  late List<Question> _questions;

  @override
  void initState() {
    _questions = sample_data
        .map(
          (question) => Question(
              id: question['id'],
              question: question['question'],
              options: question['options'],
              answer: question['answer_index']),
        )
        .toList();

    _questions.forEach((element) {
      pages.add(Quiz(
        question: element,
      ));
    });

    PerfilAnalysis.numberOfPages = pages.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: PerfilAnalysis.questionPageViewController,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: pages[index] as Widget,
              );
            }),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  // const Quiz({Key? key}) : super(key: key);
  Question question;

  Quiz({required this.question});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 38.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "${widget.question.question}",
                style: TextStyle(
                    fontSize: size.width / 14,
                    fontFamily: 'Poppins-SemiBold',
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              RadioGroup.builder(
                  groupValue: optionSelected,
                  onChanged: (value) {
                    setState(() {
                      optionSelected = value as String;
                    });
                    for (int i = 0; i < widget.question.options.length; i++) {
                      if (widget.question.options[i] == value as String) {
                        debugPrint("Response: ${i + 1}");
                        PerfilAnalysis.responseOfQuestion[widget.question.id] =
                            i + 1;
                      }
                    }

                    // debugPrint(value as String);
                    // widget.question.answer=
                  },
                  items: widget.question.options,
                  itemBuilder: (item) {
                    return RadioButtonBuilder(item,
                        textPosition: RadioButtonTextPosition.right);
                  })
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (optionSelected.isNotEmpty) {
                  PerfilAnalysis.currentPage++;
                  if (PerfilAnalysis.currentPage ==
                      PerfilAnalysis.numberOfPages) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GetFinanceProfile()));
                  }
                  PerfilAnalysis.questionPageViewController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Escolha uma opção!"),
                    duration: Duration(seconds: 2),
                  ));
                }
              });
            },
            child: ConfirmButton(context, "Próxima", !optionSelected.isEmpty),
          )
        ],
      ),
    );
  }
}

class GetFinanceProfile extends StatefulWidget {
  const GetFinanceProfile({Key? key}) : super(key: key);

  @override
  _GetFinanceProfileState createState() => _GetFinanceProfileState();
}

class _GetFinanceProfileState extends State<GetFinanceProfile> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Tem certeza?'),
            content: new Text('Voltará a tela anterior'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  PerfilAnalysis.currentPage--;
                  return Navigator.of(context).pop(true);
                },
                child: new Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: MhadiaService.getUserFinancePerfil(
                      PerfilAnalysis.responseOfQuestion),
                  builder: (ctx, snap) {
                    if (!snap.hasData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 100,
                                child:
                                    Lottie.asset(AppFiles.loading_animation)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Aguarde estamos analisando o teu perfil financeiro...",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }

                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Com base as suas resposta, detectamos que possuí um perfil financeiro:",
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                // fontStyle: 'Poppins-Regular',
                                fontSize:
                                    MediaQuery.of(context).size.width / 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${snap.data}",
                            style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize:
                                    MediaQuery.of(context).size.width / 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                App.user!.financialProfile =
                                    snap.data as String;
                                AuthController.setOpenFirstTime(false);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => RootApp()),
                                    (route) => false);
                              },
                              child: ConfirmButton(context, "Iniciar", true))
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
