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
  final focusNode6 = FocusNode();

  @override
  void dispose() {
    focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DInput(
              controller: controller1,
              hint: 'sample 1',
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller2,
              title: 'Description',
              hint: 'sample 2',
              minLine: 3,
              maxLine: 5,
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller3,
              hint: 'sample 3',
              boxColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              inputStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              shapeBoxBorder: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller4,
              hint: 'sample 4',
              boxBorderRadius: BorderRadius.circular(8),
              boxBorder: const BorderSide(width: 2, color: Colors.green),
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller5,
              hint: 'sample 5',
              inputPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: const IconSpec(
                icon: Icons.email,
                color: Colors.green,
              ),
              suffixIcon: IconSpec(
                icon: Icons.verified,
                color: Colors.blue,
                onTap: () {
                  // cursor move to sample 6
                  focusNode6.requestFocus();
                },
              ),
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller6,
              inputFocusNode: focusNode6,
              hint: 'sample 6',
              inputPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              inputMargin: const EdgeInsets.symmetric(vertical: 8),
              inputBackgroundColor: Colors.amber.withValues(alpha: 0.3),
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
            DInput(
              controller: controller7,
              hint: 'sample 7',
              noBoxBorder: true,
              inputOnFieldSubmitted: (value) {
                print('submit: $value');
              },
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller8,
              hint: 'sample 8',
              minLine: 3,
              maxLine: 3,
              crossAxisAlignmentBox: CrossAxisAlignment.start,
              inputPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              inputMargin: const EdgeInsets.symmetric(vertical: 8),
              inputBackgroundColor: Colors.grey.withValues(alpha: 0.2),
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
            DInput(
              controller: controller9,
              hint: 'sample 9..\nline 2..\nline 3..',
              crossAxisAlignmentBox: CrossAxisAlignment.start,
              boxBorder: const BorderSide(color: Colors.transparent),
              boxColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
              boxBorderRadius: BorderRadius.circular(10),
              minLine: 3,
              maxLine: 3,
              inputPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: const IconSpec(icon: Icons.description),
            ),
            const SizedBox(height: 20),
            DInput(
              controller: controller10,
              title: 'Choose Date',
              hint: 'sample 10',
              crossAxisAlignmentTitle: CrossAxisAlignment.end,
              inputPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              suffixIcon: IconSpec(
                icon: Icons.event,
                splashColor: Colors.green.shade300,
                onTap: () {
                  // date picker and set to controller
                },
              ),
            ),
            const SizedBox(height: 20),
            DInput(
              title: 'Left Children',
              hint: 'sample 11',
              inputPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              prefixIcon: IconSpec(
                icon: Icons.event,
                onTap: () {},
              ),
              leftChildren: const [
                Icon(Icons.reset_tv),
                Icon(Icons.ac_unit),
              ],
            ),
            const SizedBox(height: 20),
            DInput(
              title: 'Right Children',
              hint: 'sample 12',
              inputPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              rightChildren: const [
                Icon(Icons.reset_tv),
                Icon(Icons.ac_unit),
              ],
              suffixIcon: IconSpec(
                icon: Icons.event,
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            DInput(
              title: 'Both Children',
              hint: 'sample 13',
              inputPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              prefixIcon: IconSpec(
                icon: Icons.arrow_back,
                onTap: () {},
              ),
              leftChildren: const [
                Icon(Icons.reset_tv),
                Icon(Icons.ac_unit),
              ],
              rightChildren: const [
                Icon(Icons.reset_tv),
                Icon(Icons.ac_unit),
              ],
              suffixIcon: IconSpec(
                icon: Icons.arrow_forward,
                onTap: () {},
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
              inputBackgroundColor: Colors.amber.withValues(alpha: 0.3),
              icon: const Icon(Icons.keyboard_arrow_down),
              suffixIcon: IconSpec(
                icon: Icons.add_circle,
                onTap: () => print(dropdownValue3),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
