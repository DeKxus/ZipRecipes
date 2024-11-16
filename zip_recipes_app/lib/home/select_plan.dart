import 'package:flutter/material.dart';

import '../widgets/build_plan_option.dart';
import '../widgets/plan_option.dart';

class SelectPlan extends StatefulWidget {
  const SelectPlan({super.key});

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  final List<PlanOption> planOptions = [
    PlanOption(
      title: 'Sports',
      description:
      'A more specialized plan with calorie tracking and more rigorous meal choosing',
      icon: Icons.sports_tennis,
      iconColor: Colors.purple,
    ),
    PlanOption(
      title: 'Normal',
      description:
      'An every day use plan that present new and fun recipes, improving your eating habits',
      icon: Icons.calendar_today,
      iconColor: Colors.blueGrey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ...planOptions.map((plan) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: PlanOptionCard(plan: plan),
            )),
            const Spacer(),
            const Center(
              child: Text(
                'Don\'t worry, you can change this at any time!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
