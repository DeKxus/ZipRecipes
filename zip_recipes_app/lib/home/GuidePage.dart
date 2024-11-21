import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/widgets/custom_pill_button.dart';
import 'package:zip_recipes_app/widgets/step_load_bar.dart';
import 'dart:async';

class GuidePage extends StatefulWidget {
  final List<RecipeStep> guide;
  const GuidePage({super.key, required this.guide});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int currentStep = 0;
  final Map<int, int> timers = {}; // Map to store remaining time for each step
  final Map<int, Timer?> activeTimers = {}; // Map to store active timers
  final RecipeStep finalStep = RecipeStep(description: "You have finished! Please enjoy your dish 🎉", timer: null);

  @override
  void dispose() {
    // Cancel all active timers
    for (var timer in activeTimers.values) {
      timer?.cancel();
    }
    super.dispose();
  }

  void startTimer(int stepIndex, int seconds) {
    // Cancel any existing timer for the same step
    activeTimers[stepIndex]?.cancel();

    setState(() {
      timers[stepIndex] = seconds;
    });

    // Start a new timer
    activeTimers[stepIndex] = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timers[stepIndex]! > 0) {
          timers[stepIndex] = timers[stepIndex]! - 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void navigateStep(int stepChange) {
    setState(() {
      currentStep = (currentStep + stepChange).clamp(0, widget.guide.length - 1);
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final currentGuideStep = currentStep == widget.guide.length - 1
        ? finalStep
        : widget.guide[currentStep];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            // Step-by-step load bar
            StepLoadBar(totalSteps: widget.guide.length, currentStep: currentStep + 1),

            // Guide and Timer
            Expanded(
              child: Container(
                height: 520,
                child: Column(
                  children: [
                    // Persistent Timers Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Timers",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            spacing: 8.0,
                            children: timers.entries.map((entry) {
                              return CustomPillButton(
                                text: "Step ${entry.key + 1}: ${formatTime(entry.value)}",
                                onPressed: () {}, // No action needed
                                buttonColor: const Color(0xFFFFAAAB),
                                horizontalPadding: 12,
                                verticalPadding: 0,
                                fontSize: 14,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Step Information
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentGuideStep.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),

                            // Navigation Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (currentStep > 0)
                                  CustomPillButton(
                                    text: 'Back',
                                    onPressed: () => navigateStep(-1),
                                    buttonColor: const Color(0xFFFFAAAB),
                                    horizontalPadding: 6,
                                    verticalPadding: 4,
                                    fontSize: 14,
                                  ),
                                if (currentStep < widget.guide.length - 1)
                                  CustomPillButton(
                                    text: 'Next',
                                    onPressed: () => navigateStep(1),
                                    buttonColor: const Color(0xFF86D293),
                                    horizontalPadding: 6,
                                    verticalPadding: 4,
                                    fontSize: 14,
                                  ),
                                if (currentGuideStep.timer != null)
                                  CustomPillButton(
                                    text: 'Set Timer',
                                    onPressed: () => startTimer(currentStep, currentGuideStep.timer! * 60),
                                    buttonColor: const Color(0xFF8E8E8E),
                                    horizontalPadding: 6,
                                    verticalPadding: 4,
                                    fontSize: 14,
                                  ),

                                if (currentStep == widget.guide.length - 1)
                                  CustomPillButton(
                                    text: 'Done',
                                    onPressed: () {
                                      //TODO update calories
                                      Navigator.pop(context);
                                    },
                                    buttonColor: const Color(0xFF86D293),
                                    horizontalPadding: 6,
                                    verticalPadding: 4,
                                    fontSize: 14,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}