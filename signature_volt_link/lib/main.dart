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
              color: Colors.white,
              fontSize: 25,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 88, 43, 131)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ))),
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
  String pronomDropdownValue = 'Sie';
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
    var widthDesktopCardForm = MediaQuery.of(context).size.width * 0.40;
    var heightDesktopCardForm = MediaQuery.of(context).size.height * 0.70;

    var widthDesktopCardPreview = MediaQuery.of(context).size.width * 0.50;
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
                  formView(widthDesktopCardForm, heightDesktopCardForm),
                  const SizedBox(
                    width: 25,
                  ),
                  previewView(
                      widthDesktopCardPreview, heightDesktopCardPreview),
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
      width: widthDesktopCardForm,
      height: heightDesktopCardPreview,
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
                    hintText: 'jean.placeholder@volteurope.eu',
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
                child: DropdownButton(
                  isExpanded: true,
                  value: pronomDropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  underline: Container(
                    height: 0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      pronomDropdownValue = newValue!;
                    });
                  },
                  items: <String>['Sie', 'Er']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget previewView(widthDesktopCardForm, heightDesktopCardPreview) {
    return Container(
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
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Dein Ding.",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            SizedBox(
              height: defaultHeightSizedBox,
            ),
            const Text(
              "Lorem ipsum whatever, text description must be longer",
              style: TextStyle(color: Colors.white),
            ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
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
              child: ElevatedButton(
                onPressed: () {
                  _controllerTopCenter.play();
                },
                child: const Text('Gmail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
