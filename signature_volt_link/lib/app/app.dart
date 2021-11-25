// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:signature_volt_link/signature/signature.dart';
import 'package:signature_volt_link/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SignaturePage(),
    );
  }
}
