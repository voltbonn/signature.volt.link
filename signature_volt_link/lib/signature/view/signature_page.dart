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
      create: (_) => SignatureCubit(),
      child: SignatureView(),
    );
  }
}

class SignatureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                child: Text(l10n.signatureAppBarTitle,
                    style: Theme.of(context).textTheme.headline1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignatureForm(),
                  SizedBox(width: 25),
                  SignaturePreview(
                    confettiController:
                        context.read<SignatureCubit>().confettiController,
                  ),
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
                      onPressed: () => context.read<SignatureCubit>().launchURL(
                          "https://www.voltdeutschland.org/impressum"),
                    ),
                    footerDivider(context),
                    TextButton(
                      child: Text(
                        "Datenschutz",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => context.read<SignatureCubit>().launchURL(
                          "https://www.voltdeutschland.org/datenschutz"),
                    ),
                    footerDivider(context),
                    TextButton(
                      child: Text(
                        "Quellcode",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => context.read<SignatureCubit>().launchURL(
                          "https://github.com/voltbonn/signature.volt.link"),
                    ),
                    footerDivider(context),
                    TextButton(
                      child: Text(
                        "Kontakt",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () => context
                          .read<SignatureCubit>()
                          .launchURL("mailto:"), // TODO: Add mail
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

  Widget footerDivider(BuildContext context) {
    return Text(
      "  •  ",
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class SignatureText extends StatelessWidget {
  const SignatureText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((SignatureCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
