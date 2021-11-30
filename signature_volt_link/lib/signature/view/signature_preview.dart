import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:formz/formz.dart';
import 'package:signature_volt_link/config/volt_color.dart';
import 'package:signature_volt_link/l10n/l10n.dart';
import 'package:signature_volt_link/signature/signature.dart';

class SignaturePreview extends StatelessWidget {
  final ConfettiController confettiController;
  const SignaturePreview({Key? key, required this.confettiController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    var widthDesktopPreview = MediaQuery.of(context).size.width * 0.90;
    if (isScreenWide) {
      widthDesktopPreview = MediaQuery.of(context).size.width * 0.50;
    }
    var defaultHeightSizedBox = 15.0;
    final l10n = context.l10n;
    // TODO: Duplicated with signature_bloc
    Path drawStar(Size size) {
      // Method to convert degree to radians
      double degToRad(double deg) => deg * (pi / 180.0);

      const numberOfPoints = 5;
      final halfWidth = size.width / 2;
      final externalRadius = halfWidth;
      final internalRadius = halfWidth / 2.5;
      final degreesPerStep = degToRad(360 / numberOfPoints);
      final halfDegreesPerStep = degreesPerStep / 2;
      final path = Path();
      final fullAngle = degToRad(360);
      path.moveTo(size.width, halfWidth);

      for (double step = 0; step < fullAngle; step += degreesPerStep) {
        path.lineTo(halfWidth + externalRadius * cos(step),
            halfWidth + externalRadius * sin(step));
        path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
            halfWidth + internalRadius * sin(step + halfDegreesPerStep));
      }
      path.close();
      return path;
    }

    return BlocBuilder<SignatureBloc, SignatureState>(
      buildWhen: (previous, current) =>
          previous.htmlSignature != current.htmlSignature,
      builder: (context, state) {
        return SizedBox(
          width: widthDesktopPreview,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirection: pi / 3,
                    maxBlastForce: 2, // set a lower max blast force
                    minBlastForce: 1, // set a lower min blast force
                    emissionFrequency: 0.05,
                    numberOfParticles: 50, // a lot of particles at once
                    gravity: 0.3,
                    colors: const [
                      VoltColor.blue,
                      VoltColor.green,
                      VoltColor.red,
                      VoltColor.yellow
                    ],
                    createParticlePath: drawStar,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      l10n.previewHeadline,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                Text(l10n.previewDescription),
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
                              color: VoltColor.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              color: VoltColor.yellow,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              color: VoltColor.green,
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
                      width: widthDesktopPreview,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(l10n.previewFromText),
                            Text(l10n.previewSubjectText),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: HtmlWidget(
                          state.htmlSignature,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: state.status.isValidated
                        ? () =>
                            context.read<SignatureBloc>().add(FormSubmitted())
                        : null,
                    child: Text(l10n.copyMailSignatureButtonText),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
