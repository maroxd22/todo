import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_container.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.result,
    required this.age,
    required this.isMale,
  });
  final int result;
  final int age;
  final bool isMale;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomContainer(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Gender : ${isMale ? 'MALE' : 'FEMALE'}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Result = $result',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Age : $age',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          CustomButton(
            ontap: () {
              Navigator.pop(context);
            },
            buttonText: 'ReCalculate',
          ),
        ],
      ),
    );
  }
}