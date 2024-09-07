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
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();
  final controller7 = TextEditingController();
  final controller8 = TextEditingController();
  final controller9 = TextEditingController();
  final controller10 = TextEditingController();
  final controller11 = TextEditingController();
  bool obscure = false;

  List<String> levels = [
    'Beginner',
    'Junior',
    'Intermediet',
    'Senior',
    'Expert',
  ];
  String dropdownValue1 = 'Beginner';
  String dropdownValue2 = 'Beginner';
  String dropdownValue3 = 'Beginner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('D Input'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DInput(
            controller: TextEditingController(),
          ),
          const SizedBox(height: 20),
          DInputPassword(
            controller: TextEditingController(),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller1,
            hint: 'sample mix 1',
            noBoxBorder: true,
            inputOnFieldSubmitted: (value) {
              print('submit: $value');
            },
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller2,
            title: 'Description',
            hint: 'sample mix 2',
            minLine: 3,
            maxLine: 5,
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller3,
            hint: 'sample mix 3',
            boxColor: Theme.of(context).primaryColor.withOpacity(0.4),
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.white,
            ),
            inputStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller4,
            hint: 'sample mix 4',
            boxRadius: 8,
            boxBorder: Border.all(
              width: 2,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller5,
            hint: 'sample mix 5',
            prefixIcon: IconSpec(
              icon: Icons.email,
              onTap: () => print('Icons.email'),
            ),
            suffixIcon: IconSpec(
              icon: Icons.verified,
              onTap: () => print('Icons.verified'),
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller6,
            hint: 'sample mix 6',
            inputPadding: const EdgeInsets.symmetric(vertical: 16),
            prefixIcon: const IconSpec(
              icon: Icons.email,
              color: Colors.green,
            ),
            suffixIcon: const IconSpec(
              icon: Icons.verified,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller7,
            hint: 'sample mix 7',
            inputPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            inputMargin: const EdgeInsets.symmetric(vertical: 8),
            inputBackgroundColor: Colors.amber.withOpacity(0.3),
            inputRadius: 10,
            prefixIcon: const IconSpec(
              icon: Icons.email,
              color: Colors.green,
            ),
            suffixIcon: const IconSpec(
              icon: Icons.verified,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller8,
            hint: 'sample mix 8',
            inputPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            inputBackgroundColor: Colors.amber.withOpacity(0.3),
            inputRadius: 12,
            prefixIcon: const IconSpec(
              icon: Icons.email,
              color: Colors.green,
              alignment: Alignment(0.3, 0),
              boxSize: Size(40, 56),
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller9,
            hint: 'sample mix 9',
            minLine: 3,
            maxLine: 3,
            crossAxisAlignmentBox: CrossAxisAlignment.start,
            inputPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            inputMargin: const EdgeInsets.symmetric(vertical: 8),
            inputBackgroundColor: Colors.grey.withOpacity(0.2),
            inputRadius: 12,
            prefixIcon: const IconSpec(
              icon: Icons.image,
              color: Colors.green,
            ),
            suffixIcon: const IconSpec(
              icon: Icons.send,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller10,
            hint: 'sample mix 10..\nline 2..\nline 3..',
            crossAxisAlignmentBox: CrossAxisAlignment.start,
            boxBorder: Border.all(color: Colors.transparent),
            boxColor: Theme.of(context).primaryColor.withOpacity(0.3),
            boxRadius: 10,
            minLine: 3,
            maxLine: 3,
            inputPadding: const EdgeInsets.symmetric(vertical: 16),
            prefixIcon: const IconSpec(icon: Icons.description),
          ),
          const SizedBox(height: 20),
          DInputMix(
            controller: controller11,
            title: 'Choose Date',
            hint: 'sample mix 11',
            crossAxisAlignmentTitle: CrossAxisAlignment.end,
            inputPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
            boxRadius: 20,
            suffixIcon: IconSpec(
              icon: Icons.event,
              splashColor: Colors.green.shade300,
              margin: const EdgeInsets.all(2),
              radius: 20 - 2,
              onTap: () {
                // date picker and set to controller
              },
            ),
          ),
          const SizedBox(height: 20),
          DInputDropdown<String>(
            value: dropdownValue1,
            inputOnChanged: (value) {},
            items: levels.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            title: 'Dropdown 1',
          ),
          const SizedBox(height: 20),
          DInputDropdown<String>(
            value: dropdownValue2,
            inputOnChanged: (value) {},
            items: levels.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            title: 'Dropdown 2',
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
          const SizedBox(height: 20),
          DInputDropdown<String>(
            value: dropdownValue3,
            inputOnChanged: (value) {
              if (value == null) return;
              dropdownValue3 = value;
            },
            items: levels.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            title: 'Dropdown 3',
            inputRadius: 12,
            inputMargin: const EdgeInsets.only(left: 8),
            inputPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            inputBackgroundColor: Colors.amber.withOpacity(0.3),
            icon: const Icon(Icons.keyboard_arrow_down),
            suffixIcon: IconSpec(
              icon: Icons.add_circle,
              onTap: () => print(dropdownValue3),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
