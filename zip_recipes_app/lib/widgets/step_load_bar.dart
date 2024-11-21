import 'package:flutter/material.dart';

class StepLoadBar extends StatefulWidget {
  final int totalSteps; // Total number of steps
  final int currentStep; // Current completed step
  final double barHeight; // Height of the bar
  final double barWidth; // Width of the bar
  final Color unfilledColor; // Color for unfilled bar
  final Color filledColor; // Color for filled bar

  const StepLoadBar({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
    this.barHeight = 580,
    this.barWidth = 22,
    this.unfilledColor = const Color(0xFFBEDBC3),
    this.filledColor = const Color(0xFF86D293),
  }) : super(key: key);

  @override
  _StepLoadBarState createState() => _StepLoadBarState();
}

class _StepLoadBarState extends State<StepLoadBar> {
  @override
  Widget build(BuildContext context) {
    // Calculate the height for the filled section based on the current step
    final double filledHeight =
        (widget.currentStep / widget.totalSteps) * widget.barHeight;

    String result = widget.currentStep.toString() +"/" + widget.totalSteps.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: 50,
        height: 620,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 580,
              left: 30,
              child: Text(
                result,
                style: const TextStyle(
                    color: Color(0xFF86D293),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            //Unfilled elements
            Container(
              width: 22,
              height: 580,
              decoration: BoxDecoration(
                color: Color(0xFFBEDBC3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              bottom: 0, // Move the circle halfway out of the bottom of the bar
              left: -16, // Center the circle horizontally over the rectangle
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFBEDBC3),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            //Filled elements
            Container(
              width: 22,
              height: filledHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF86D293),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            if (widget.currentStep == widget.totalSteps)
              Positioned(
                bottom: 0,
                left: -16,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.filledColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

            Positioned(
              bottom: 20,
              left: 2,
              child:  SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/images/icons/flag.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
