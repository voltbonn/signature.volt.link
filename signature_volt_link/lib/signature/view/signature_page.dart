// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:signature_volt_link/config/volt_color.dart';
import 'package:signature_volt_link/signature/signature.dart';
import 'package:signature_volt_link/l10n/l10n.dart';
import 'package:signature_volt_link/signature/view/signature_form.dart';
import 'package:signature_volt_link/signature/view/signature_preview.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignatureBloc(),
        child: const Signature(),
      ),
    );
  }
}

class Signature extends StatefulWidget {
  const Signature({Key? key}) : super(key: key);

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _positionFocusNode = FocusNode();
  final _pronomFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<SignatureBloc>().add(NameUnfocused());
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignatureBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_locationFocusNode);
      }
    });
    _locationFocusNode.addListener(() {
      if (!_locationFocusNode.hasFocus) {
        context.read<SignatureBloc>().add(LocationUnfocused());
        FocusScope.of(context).requestFocus(_positionFocusNode);
      }
    });
    _positionFocusNode.addListener(() {
      if (!_positionFocusNode.hasFocus) {
        context.read<SignatureBloc>().add(PositionUnfocused());
      }
    });
    _pronomFocusNode.addListener(() {
      if (!_pronomFocusNode.hasFocus) {
        context.read<SignatureBloc>().add(PronomUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _locationFocusNode.dispose();
    _positionFocusNode.dispose();
    _pronomFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SignatureBloc, SignatureState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<SignatureBloc>().confettiController.play();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Mail signature is in your Clipboard'),
                backgroundColor: VoltColor.green,
              ),
            );
        }
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Prepare mail signature...')),
            );
        }
      },
      child: Container(
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
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flex(
                  direction: context.read<SignatureBloc>().isScreenWide(context)
                      ? Axis.horizontal
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignatureForm(
                      focusNodeName: _nameFocusNode,
                      focusNodeMail: _emailFocusNode,
                      focusNodeLocation: _locationFocusNode,
                      focusNodePosition: _positionFocusNode,
                    ),
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
                              .launchURL(
                                  "mailto:dominik.springer@volteuropa.org"),
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
