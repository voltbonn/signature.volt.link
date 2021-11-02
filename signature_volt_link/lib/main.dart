import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import "dart:math" show pi;

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signatur Generator',
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: const Color.fromARGB(255, 88, 43, 131),
          primarySwatch: const MaterialColor(
            0x582b83, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
            <int, Color>{
              50: Color(0xff69408f), //10%
              100: Color(0xff79559c), //20%
              200: Color(0xff8a6ba8), //30%
              300: Color(0xff9b80b5), //40%
              400: Color(0xffac95c1), //50%
              500: Color(0xffbcaacd), //60%
              600: Color(0xffcdbfda), //70%
              700: Color(0xffded5e6), //80%
              800: Color(0xffeeeaf3), //90%
              900: Color(0xffffffff), //100%
            },
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
            headline2: TextStyle(
              color: Color.fromARGB(255, 88, 43, 131),
              fontWeight: FontWeight.bold,
              fontSize: 37,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 88, 43, 131)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          )),
      home: const MyHomePage(title: 'Signatur Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConfettiController _controllerTopCenter;
  var defaultHeightSizedBox = 15.0;
  String pronomDropdownValue = 'One';
  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthDesktopCardForm = MediaQuery.of(context).size.width * 0.45;
    var heightDesktopCardPreview = MediaQuery.of(context).size.height * 0.70;
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 20, 0, 34),
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SvgPicture.asset('images/volt_logo_purple.svg')),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("Mail Signature Generator",
                    style: Theme.of(context).textTheme.headline1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  formView(widthDesktopCardForm, heightDesktopCardPreview),
                  const SizedBox(
                    width: 25,
                  ),
                  previewView(widthDesktopCardForm, heightDesktopCardPreview),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        "Impressum",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => launchURL(
                          "https://www.voltdeutschland.org/impressum"),
                    ),
                    footerDivider(),
                    TextButton(
                      child: Text(
                        "Datenschutz",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => launchURL(
                          "https://www.voltdeutschland.org/datenschutz"),
                    ),
                    footerDivider(),
                    TextButton(
                      child: Text(
                        "Quellcode",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => launchURL(
                          "https://github.com/voltbonn/signature.volt.link"),
                    ),
                    footerDivider(),
                    TextButton(
                      child: Text(
                        "Kontakt",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => launchURL("mailto:"), // TODO: Add mail
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  Widget footerDivider() {
    return Text(
      "  •  ",
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget formView(widthDesktopCardForm, heightDesktopCardPreview) {
    return Container(
      color: Colors.white,
      width: widthDesktopCardForm,
      height: heightDesktopCardPreview,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deine Daten.",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text("Lorem ipsum whatever, text description must be longer"),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your name',
                hintText: 'Test',
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your mail',
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your location',
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your position',
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            Text(
              "Pronom question",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            DropdownButton(
              isExpanded: true,
              value: pronomDropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Theme.of(context).primaryColor),
              underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  pronomDropdownValue = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget previewView(widthDesktopCardForm, heightDesktopCardPreview) {
    return Container(
      color: Colors.white,
      width: widthDesktopCardForm,
      height: heightDesktopCardPreview,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: pi / 3,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.05,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.5,
              ),
            ),
            Text(
              "Dein Ding.",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text("Lorem ipsum whatever, text description must be longer"),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 51, 71, 91),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(0.0)),
                  ),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 71, 91, 108),
                  height: 2,
                ),
                Container(
                  color: const Color.fromARGB(255, 51, 71, 91),
                  height: 60,
                  width: widthDesktopCardForm * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("An: volt@volteuropa.org"),
                        Text("Betreff: Meine neue Volt Signatur"),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(10.0)),
                      border: Border.all(
                          width: 1.0,
                          color: const Color.fromARGB(255, 51, 71, 91))),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: HtmlWidget(
                      '''
  <b>Jean Placeholder</b><br>
  <b>DE Placholder</b>
  <p>Volt Euroopa / Volt Deutschland</p>
  <a href="mailto:jean.placeholder@volteuropa.org">jean.placeholder@volteuropa.org</a>
  <!-- anything goes here -->
  ''',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            Container(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  _controllerTopCenter.play();
                },
                icon: const Icon(Icons.copy),
                label: const Text('Gmail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
