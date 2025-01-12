import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/assets.dart';

import '../../../../domain/entities/tips.dart';

Future<void> tipsDialog(BuildContext context, Tips tips) async {
  var size = MediaQuery.of(context).size;
  var isLoading = false.obs;

  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(image: AssetImage(AppAssets.MhadiaLogo)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(
                                Icons.close_sharp,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        tips.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Text(
                          tips.message,
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  )),
            )),
          ),
        );
      },
      barrierDismissible: !isLoading.value);

  return;
}
