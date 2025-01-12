import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/presenter/pages/newhome/domain/entities/total_transaction.dart';

import '../../../../../../../shared/presentation/ui/spacing.dart';

class TotalTransactionCard extends StatefulWidget {
  TotalTransaction totalTransation;

  TotalTransactionCard({super.key, required this.totalTransation});

  @override
  State<TotalTransactionCard> createState() => _TotalTransactionCardState();
}

class _TotalTransactionCardState extends State<TotalTransactionCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  BorderRadius get borderRadius => BorderRadius.circular(18);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: () {
          debugPrint("Navigate...");
        },
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.totalTransation.type == Type.expense
                          ? const Color(0xFFFF5454)
                          : const Color(0xFF3CDE87)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.totalTransation.type == Type.expense
                    ? const Icon(Icons.arrow_downward_outlined,
                        size: 15, color: Color(0xFFFF5454))
                    : const Icon(Icons.arrow_upward_outlined,
                        size: 15, color: Color(0xFF3CDE87)),
              ),
              const Spacing.y(),
              const Spacer(),
              Text(
                  widget.totalTransation.type == Type.expense
                      ? "Despesas"
                      : "Receitas",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 18),
                        child: Text(
                          "${widget.totalTransation.value}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 18),
                        )),
                  ),
                  Icon(Icons.chevron_right_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
