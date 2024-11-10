import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

              //Scan text element
              Container(
                width: 150.0,
                height: 150.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  shape: BoxShape.circle, 
                ),
                child: Center(
                  child: Column(children: [
                    Image.asset(
                      'assets/images/icons/scan_text.png',
                      fit: BoxFit.contain, 
                    ),

                    Text(
                      'Scan text',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8E8E8E),
                      ),
                    )
                    ],
                  ),
                ),
              ),
              
              //Insert list element
               Container(
                width: 150.0,
                height: 150.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  shape: BoxShape.circle, 
                ),
                child: Center(
                  child: Column(children: [
                    Image.asset(
                      'assets/images/icons/pencil.png',
                      fit: BoxFit.contain, 
                    ),

                    Text(
                      'Insert list',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8E8E8E),
                      ),
                    )
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