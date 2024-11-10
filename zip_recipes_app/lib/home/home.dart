import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zip_recipes_app/home/scan.dart';
import 'package:zip_recipes_app/widgets/custom_circular_buttons.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Scan Page Button
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 80.0, top:50.0),
              child: CustomCircularButton(
                imagePath: 'assets/images/icons/scan.png',
                padding: 25.0,
                diameter: 120.0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanPage()),
                  );
                },
              ),
            ),
          ),

          //Groceries Page Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: CustomCircularButton(
                imagePath: 'assets/images/icons/groceries.png',
                padding: 25.0,
                diameter: 120.0,
                onTap: () {
                  print("button pressed");
                },
              ),
            ),
          ),

          //Recipe Page Button
          Align(
            alignment: Alignment.center,
            child:CustomCircularButton(
              imagePath: 'assets/images/icons/food.png',
              padding: 0.0,
              diameter: 230.0,
              onTap: () {
                print("button pressed");
              },
            ),
          ),
        

          //Water Button
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: CustomCircularButton(
                imagePath: 'assets/images/icons/water.png',
                padding: 20.0,
                diameter: 110.0,
                onTap: () {
                  print("button pressed");
                },
              ),
            ),
          ),
          
        ],
      )
    );
  }
}