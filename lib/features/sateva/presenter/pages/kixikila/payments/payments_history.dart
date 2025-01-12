import 'package:flutter/material.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';
import 'package:kumbuz/features/sateva/domain/usecases/kixikila_usecases/payments/get_all_usecase.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/payments/components/kixi_payment_component.dart';

class KixikilaPaymentsHistory extends StatefulWidget {
  Kixikila kixikila;

  KixikilaPaymentsHistory({required this.kixikila});

  @override
  State<KixikilaPaymentsHistory> createState() =>
      _KixikilaPaymentsHistoryState();
}

class _KixikilaPaymentsHistoryState extends State<KixikilaPaymentsHistory> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pagamentos"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
            future: DI
                .get<KixikilaPaymentGetAllUsecase>()
                .handle(widget.kixikila.id as String),
            builder: (ctx, snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snap.data ?? [];

              if (data.isEmpty) {
                return const Center(
                  child: Text("Ainda não foi registado algum pagamento."),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: snap.data!.map((element) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KixiPaymentComponent(payment: element),
                    );
                  }).toList(),
                ),
              );
            }),
      ),
    );
  }
}
