import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/utils/currency_utils.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/controller/kixikila_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/details/details_page.dart';
import 'package:kumbuz/main.dart';

class KixikilaCardWidget extends StatefulWidget {
  Kixikila kixikila;

  KixikilaCardWidget({required this.kixikila});

  @override
  State<KixikilaCardWidget> createState() => _KixikilaCardWidgetState();
}

class _KixikilaCardWidgetState extends State<KixikilaCardWidget> {
  var users = <KixikilaGuest>[].obs;
  var controller = DI.get<KixikilaController>();

  @override
  initState() {
    super.initState();

    controller
        .getUsersByKixikila(widget.kixikila.id as String)
        .then((value) => users.value = value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  KixikilaDetails(kixikila: widget.kixikila)));
        },
        child: Container(
            width: size.width,
            height: size.height * 0.19,
            decoration: AppStyles.containerDecoration(context),
            child: Obx(() {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.kixikila.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(currencyFormatUtils(widget.kixikila.amount)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(DateTimeManipulation().getDataByTypePayment(
                                widget.kixikila.paymentDate)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.group,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${users.value.length}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   left: size.width * 0.80,
                  //   child: widget.kixikila.createdBy == App.user?.uuId
                  //       ? PopupMenuButton(
                  //           itemBuilder: (context) {
                  //             return [
                  //               PopupMenuItem(
                  //                   onTap: () {
                  //
                  //                   },
                  //                   child: const Row(
                  //                     children: [
                  //                       Icon(Icons.edit),
                  //                       SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                       Text(
                  //                         "Editar",
                  //                         style: TextStyle(color: Colors.black),
                  //                       )
                  //                     ],
                  //                   )),
                  //               PopupMenuItem(
                  //                 child: const Row(
                  //                   children: [
                  //                     Icon(Icons.delete),
                  //                     SizedBox(
                  //                       width: 5,
                  //                     ),
                  //                     Text(
                  //                       "Eliminar",
                  //                       style: TextStyle(color: Colors.black),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 onTap: () {
                  //                   // controller.deleteShoppinglist(shoppinglist);
                  //                 },
                  //               )
                  //             ];
                  //           },
                  //           icon: Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 2,
                  //               ),
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 2,
                  //               ),
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 5,
                  //               )
                  //             ],
                  //           ),
                  //           color: Color(0xfff5f5f5),
                  //         )
                  //       : PopupMenuButton(
                  //           itemBuilder: (context) {
                  //             return [
                  //               PopupMenuItem(
                  //                 child: const Row(
                  //                   children: [
                  //                     Icon(Icons.login),
                  //                     SizedBox(
                  //                       width: 5,
                  //                     ),
                  //                     Text(
                  //                       "Sair da kixikila",
                  //                       style: TextStyle(color: Colors.black),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 onTap: () {
                  //                   // controller.deleteShoppinglist(shoppinglist);
                  //                 },
                  //               )
                  //             ];
                  //           },
                  //           icon: Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 2,
                  //               ),
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 2,
                  //               ),
                  //               CircleAvatar(
                  //                 radius: 3,
                  //                 backgroundColor: Colors.grey[300],
                  //               ),
                  //               SizedBox(
                  //                 width: 5,
                  //               )
                  //             ],
                  //           ),
                  //           color: Color(0xfff5f5f5),
                  //         ),
                  // )
                ],
              );
            })),
      ),
    );
  }
}
