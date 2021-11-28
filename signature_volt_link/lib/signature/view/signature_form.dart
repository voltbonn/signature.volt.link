import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature_volt_link/signature/signature.dart';

class SignatureForm extends StatelessWidget {
  const SignatureForm(
      {Key? key,
      required this.focusNodeName,
      required this.focusNodeMail,
      required this.focusNodeLocation,
      required this.focusNodePosition})
      : super(key: key);

  final FocusNode focusNodeName;
  final FocusNode focusNodeMail;
  final FocusNode focusNodeLocation;
  final FocusNode focusNodePosition;

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    var widthDesktopForm = MediaQuery.of(context).size.width * 0.90;
    if (isScreenWide) {
      widthDesktopForm = MediaQuery.of(context).size.width * 0.40;
    }
    var defaultHeightSizedBox = 15.0;

    return BlocBuilder<SignatureBloc, SignatureState>(
      builder: (context, state) {
        return Container(
          width: widthDesktopForm,
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
                const Text(
                    "Lorem ipsum whatever, text description must be longer"),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                const Text(
                  "Enter your name:",
                ),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.name.value,
                      focusNode: focusNodeName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Jean Placeholder',
                      ),
                      onChanged: (value) {
                        context
                            .read<SignatureBloc>()
                            .add(NameChanged(name: value));
                      },
                      textInputAction: TextInputAction.next,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.email.value,
                      focusNode: focusNodeMail,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'jean.placeholder@volteurope.org',
                      ),
                      onChanged: (value) {
                        context
                            .read<SignatureBloc>()
                            .add(EmailChanged(email: value));
                      },
                      textInputAction: TextInputAction.next,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.location.value,
                      focusNode: focusNodeLocation,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Germany',
                      ),
                      onChanged: (value) {
                        context
                            .read<SignatureBloc>()
                            .add(LocationChanged(location: value));
                      },
                      textInputAction: TextInputAction.next,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.position.value,
                      focusNode: focusNodePosition,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Lead Placeholder',
                      ),
                      onChanged: (value) {
                        context
                            .read<SignatureBloc>()
                            .add(PositionChanged(position: value));
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                // const Text(
                //   "(Optional) Wähle aus wie Du angesprochen werden möchtest:",
                // ),
                const SizedBox(height: 2),
                // Container(
                //   color: Colors.white,
                //   child: const Padding(
                //     padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                //     child: DropdownButton(
                //       isExpanded: true,
                //       value: pronomDropdownValue,
                //       icon: const Icon(Icons.arrow_drop_down),
                //       iconSize: 24,
                //       elevation: 16,
                //       style: TextStyle(color: Theme.of(context).primaryColor),
                //       underline: Container(
                //         height: 0,
                //         color: Theme.of(context).primaryColor,
                //       ),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           pronomDropdownValue = newValue!;
                //         });
                //       },
                //       items: <String>['Sie', 'Er']
                //           .map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
