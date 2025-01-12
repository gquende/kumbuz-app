import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kumbuz/configs/config.dart';

import 'auth/sign_up.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    width: size.width,
                    child: SvgPicture.asset(
                      AppFiles.Onboarding1,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tenha controlo de suas finanças",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textSecundaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Saiba por onde tem ido o seu dinheiro e tenha melhores orçamentos com base seus gastos",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecundaryColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                height: 60,
                child: SizedBox.expand(
                    child: TextButton(
                  onPressed: () async {
                    print('Get It starting...');
                    //setLoading();
                    /* await _bankController.saveBankAccount(
                                      App.user, widget.bank,
                                      accountId: accountsName.first);
                                  setLoading();
                         */

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Começar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
