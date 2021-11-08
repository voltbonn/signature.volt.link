// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signature_volt_link/signature/signature.dart';
import 'package:signature_volt_link/l10n/l10n.dart';
import 'package:signature_volt_link/signature/view/signature_form.dart';
import 'package:signature_volt_link/signature/view/signature_preview.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignatureBloc(),
      child: const SignatureView(),
    );
  }
}

class SignatureView extends StatelessWidget {
  const SignatureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    final l10n = context.l10n;
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 20, 0, 34),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SvgPicture.asset('images/volt_logo_purple.svg')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    l10n.signatureAppBarTitle,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flex(
                  direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SignatureForm(),
                    const SizedBox(width: 25),
                    SignaturePreview(
                      confettiController:
                          context.read<SignatureBloc>().confettiController,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            "Impressum",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => context
                              .read<SignatureBloc>()
                              .launchURL(
                                  "https://www.voltdeutschland.org/impressum"),
                        ),
                        footerDivider(context),
                        TextButton(
                          child: Text(
                            "Datenschutz",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => context
                              .read<SignatureBloc>()
                              .launchURL(
                                  "https://www.voltdeutschland.org/datenschutz"),
                        ),
                        footerDivider(context),
                        TextButton(
                          child: Text(
                            "Quellcode",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => context.read<SignatureBloc>().launchURL(
                              "https://github.com/voltbonn/signature.volt.link"),
                        ),
                        footerDivider(context),
                        TextButton(
                          child: Text(
                            "Kontakt",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => context
                              .read<SignatureBloc>()
                              .launchURL("mailto:"), // TODO: Add mail
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget footerDivider(BuildContext context) {
    return Text(
      "  •  ",
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
