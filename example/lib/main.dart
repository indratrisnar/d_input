import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("D'Input"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 2',
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 3',
              label: 'Label 3',
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 4',
              label: 'Label 4',
              isRequired: true,
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 5',
              label: 'Label 5',
              isRequired: true,
              title: 'Title 5',
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 6',
              title: 'Title 6',
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              hint: 'Hint 7',
              title: 'Title 7',
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              label: 'Label 8',
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            const SizedBox(height: 16),
            DInput(
              isRequired: true,
              controller: TextEditingController(),
              maxLine: 4,
              minLine: 1,
              hint: 'Area',
            ),
            const SizedBox(height: 16),
            DInput(
              controller: TextEditingController(),
              maxLine: 10,
              minLine: 5,
              label: 'Description',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
