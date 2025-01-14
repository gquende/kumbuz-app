import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/details/components/guest_details.dart';

import '../../../../../../core/di/dependecy_injection.dart';
import '../../../../../../core/utils/currency_utils.dart';
import '../../../../../../core/utils/datetime_manipulation.dart';
import '../controller/kixikila_controller.dart';
import '../payments/payments_history.dart';

class KixikilaDetails extends StatefulWidget {
  Kixikila kixikila;

  KixikilaDetails({required this.kixikila, super.key});

  @override
  State<KixikilaDetails> createState() => _KixikilaDetailsState();
}

class _KixikilaDetailsState extends State<KixikilaDetails> {
  var controller = DI.get<KixikilaController>();
  var guests = <KixikilaGuest>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getGuests(widget.kixikila.id).then((value) {
      guests.value = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kixikila.description),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeadDetails(widget.kixikila),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return controller.loading.value
                    ? SizedBox(
                        height: size.height * 0.6,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : guests.value.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${guests.value.length} Convidados",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                  children: List.generate(guests.value.length,
                                      (index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GuestKixikilaComponent(
                                        guest: guests.value[index],
                                        isNextReceiver: true),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GuestKixikilaComponent(
                                      guest: guests.value[index],
                                      isNextReceiver: false),
                                );
                              }))
                            ],
                          )
                        : const SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget HeadDetails(Kixikila kixikila) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.18,
      decoration: AppStyles.containerDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currencyFormatUtils(kixikila.amount),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() {
                      return Text(
                        " ${guests.value.length} Convidados",
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateTimeManipulation().getDataByTypePayment(
                              widget.kixikila.paymentDate) ??
                          'Sem data',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KixikilaPaymentsHistory(
                              kixikila: kixikila,
                            )));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'pagamentos',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
