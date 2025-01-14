import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/presenter/pages/goals/create_goal.dart';
import 'package:provider/provider.dart';

import '../../../data/models/goals.dart';
import '../../../domain/usecases/goals_usecases.dart';
import 'components/goal_card.dart';

class SavingsPage extends StatefulWidget {
  bool canNavigation = false;
  SavingsPage({required this.canNavigation});

  @override
  State<SavingsPage> createState() => _BankAccountsPagenState();
}

class _BankAccountsPagenState extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return widget.canNavigation ? body(size) : savingsNoDone(size);
  }

  Widget body(Size size) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Objectivos"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: context.read<GoalsUsecases>().getGoalsNotDone(),
            builder: (ctx, snap) {
              if (!snap.hasData) {
                return const Center(
                  child: Text("Sem objectivos a mostrar"),
                );
              }
              var goals = snap.data as List<Goals>;

              if (goals.isEmpty) {
                return Container(
                  height: size.height * 0.7,
                  child: Center(
                    child: Text("Sem dados"),
                  ),
                );
              }

              return SizedBox(
                height: size.height * 0.9,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      children: List.generate(goals.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: GoalCard(
                            goal: goals[index],
                            canNavigate: true,
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateGoal()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget savingsNoDone(Size size) {
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: context.read<GoalsUsecases>().getGoalsNotDone(),
              builder: (ctx, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: Text("Sem objectivos a mostrar"),
                  );
                }
                var goals = snap.data as List<Goals>;

                if (goals.isEmpty) {
                  return Container(
                    height: size.height * 0.7,
                    child: Center(
                      child: Text("Sem dados"),
                    ),
                  );
                }

                return SizedBox(
                  height: size.height * 0.9,
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(goals.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child:
                                GoalCard(goal: goals[index], canNavigate: true),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
