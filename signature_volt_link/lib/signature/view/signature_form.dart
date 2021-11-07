import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignatureForm extends StatelessWidget {
  const SignatureForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 600;
    var widthDesktopForm = MediaQuery.of(context).size.width * 0.90;
    var heightDesktopForm = MediaQuery.of(context).size.height * 0.70;
    if (isScreenWide) {
      var widthDesktopForm = MediaQuery.of(context).size.width * 0.40;
    }
    var defaultHeightSizedBox = 15.0;

    return Container(
      width: widthDesktopForm,
      height: heightDesktopForm,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(0.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Deine Daten.",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text("Lorem ipsum whatever, text description must be longer"),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "Enter your name:",
            ),
            const SizedBox(height: 2),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Jean Placeholder',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "Enter your mail:",
            ),
            const SizedBox(height: 2),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'jean.placeholder@volteurope.org',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "Enter your location:",
            ),
            const SizedBox(height: 2),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Germany',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "Enter your position:",
            ),
            const SizedBox(height: 2),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Lead Placeholder',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "(Optional) Wähle aus wie Du angesprochen werden möchtest:",
            ),
            const SizedBox(height: 2),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                // child: DropdownButton(
                //   isExpanded: true,
                //   value: pronomDropdownValue,
                //   icon: const Icon(Icons.arrow_drop_down),
                //   iconSize: 24,
                //   elevation: 16,
                //   style: TextStyle(color: Theme.of(context).primaryColor),
                //   underline: Container(
                //     height: 0,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       pronomDropdownValue = newValue!;
                //     });
                //   },
                //   items: <String>['Sie', 'Er']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
