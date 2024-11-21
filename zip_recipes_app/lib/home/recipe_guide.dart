import 'dart:async';
import 'package:flutter/material.dart';

import 'navigation.dart';

class RecipeGuide extends StatefulWidget {
  final List<String> steps; // List of cooking steps passed from the previous screen

  const RecipeGuide({super.key, required this.steps});

  @override
  State<RecipeGuide> createState() => _RecipeGuideState();
}

class _RecipeGuideState extends State<RecipeGuide> {
  List<TimerInfo> timers = [];
  int maxTimers = 3;
  int currentStepIndex = 0;
  bool isExpanded = false;

  Future<void> showAddTimerDialog() async {
    String? timerName;
    String? timerMinutes;
    String? timerSeconds;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Timer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Timer Name'),
                onChanged: (value) {
                  timerName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Minutes'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  timerMinutes = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Seconds'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  timerSeconds = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int minutes = int.tryParse(timerMinutes ?? '0') ?? 0;
                int seconds = int.tryParse(timerSeconds ?? '0') ?? 0;
                int totalDurationInSeconds = (minutes * 60) + seconds;

                if (timerName != null &&
                    timerName!.isNotEmpty &&
                    totalDurationInSeconds > 0) {
                  setState(() {
                    timers.add(TimerInfo(
                        name: timerName!,
                        duration: totalDurationInSeconds,
                        remaining: totalDurationInSeconds));
                  });
                  Navigator.of(context).pop();
                  startTimer(timerName!, totalDurationInSeconds);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void startTimer(String timerName, int duration) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int index = timers.indexWhere((t) => t.name == timerName);
        if (index != -1) {
          if (timers[index].remaining > 0) {
            timers[index].remaining--;
          } else {
            timer.cancel();
            showInAppNotification(timerName);
            timers.removeAt(index); // Remove the timer when it reaches 0
          }
        }
      });
    });
  }

  void showInAppNotification(String timerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$timerName has finished!'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void nextStep() {
    if (currentStepIndex < widget.steps.length - 1) {
      setState(() {
        currentStepIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Meal Completed'),
            content: const Text('Congratulations! Your meal is ready.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NavigationPage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void previousStep() {
    if (currentStepIndex > 0) {
      setState(() {
        currentStepIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cook it'),
      ),
      body: Column(
        children: [
          // Green progress bar updates based on the step index
          LinearProgressIndicator(
            value: (currentStepIndex + 1) / widget.steps.length,
            color: const Color(0xFF86D293),
            backgroundColor: Colors.green.shade100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Step ${currentStepIndex + 1}/${widget.steps.length}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.steps[currentStepIndex],
                          maxLines: isExpanded ? null : 5,
                          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (widget.steps[currentStepIndex].length > 100)
                          Text(
                            isExpanded ? "Show less" : "Read more",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    constraints: BoxConstraints(maxHeight: 200), // Limit the height of timers list
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: timers.length,
                      itemBuilder: (context, index) {
                        int remainingMinutes = (timers[index].remaining / 60).floor();
                        int remainingSeconds = timers[index].remaining % 60;
                        return ListTile(
                          title: Text(timers[index].name),
                          trailing: Text(
                            '$remainingMinutes:${remainingSeconds.toString().padLeft(2, '0')}',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: timers.length < maxTimers ? showAddTimerDialog : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF86D293), // Green background
                    foregroundColor: Colors.white, // White text
                  ),
                  child: const Text('Start Timer'),
                ),
                ElevatedButton(
                  onPressed: currentStepIndex > 0 ? previousStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF86D293), // Green background
                    foregroundColor: Colors.white, // White text
                  ),
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF86D293), // Green background
                    foregroundColor: Colors.white, // White text
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerInfo {
  String name;
  int duration;
  int remaining;

  TimerInfo({required this.name, required this.duration, required this.remaining});
}
