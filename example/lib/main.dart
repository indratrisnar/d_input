import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestDInput(),
    );
  }
}

class TestDInput extends StatefulWidget {
  const TestDInput({super.key});

  @override
  State<TestDInput> createState() => _TestDInputState();
}

class _TestDInputState extends State<TestDInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DInput(
              boxSpec: BoxSpec(
                color: Colors.green.shade50,
                border: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              titleSpec: const TitleSpec(
                text: 'Message',
              ),
              inputSpec: InputSpec(
                controller: TextEditingController(),
                hint: 'Type message...',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white54,
                ),
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.deepPurple.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
              prefixIcon: const IconSpec(icon: Icons.contact_page),
              leftChildren: const [
                Icon(Icons.image),
                Icon(Icons.attach_file),
              ],
              rightChildren: const [
                Icon(Icons.emoji_emotions),
                Icon(Icons.mic),
              ],
              suffixIcon: const IconSpec(icon: Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
