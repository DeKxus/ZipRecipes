import 'package:flutter/material.dart';
import 'package:zip_recipes_app/home/sports_plan.dart';

import '../widgets/build_plan_option.dart';
import '../widgets/plan_option.dart';
import 'navigation.dart';

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
      title: 'Normal [Recommended for people who just wants new recipes]',
      description:
      'An every day use plan that present new and fun recipes, improving your eating habits',
      icon: Icons.calendar_today,
      iconColor: Colors.blueGrey,
    ),
  ];

  void _onPlanSelected(PlanOption plan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You selected: ${plan.title}'),
      ),
    );

    if (plan.title == 'Sports') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlanInputScreen(planTitle: plan.title, planIcon: plan.icon, iconColor: plan.iconColor),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
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
              child: InkWell(
                onTap: () => _onPlanSelected(plan),
                borderRadius: BorderRadius.circular(16),
                child: PlanOptionCard(plan: plan),
              ),
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
