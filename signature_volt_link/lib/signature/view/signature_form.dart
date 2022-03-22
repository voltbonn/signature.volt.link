import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature_volt_link/l10n/l10n.dart';
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
    final l10n = context.l10n;

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
                      l10n.formHeadline,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                Text(l10n.formDescription),
                SizedBox(
                  height: defaultHeightSizedBox,
                ),
                Text(l10n.formNameText),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.name.value,
                      focusNode: focusNodeName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.formNamePlaceholder,
                        errorText: state.name.invalid
                            ? '''Please enter your name.'''
                            : null,
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
                Text(l10n.formMailText),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.email.value,
                      focusNode: focusNodeMail,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: state.email.invalid
                            ? '''Mail must be valid.'''
                            : null,
                        helperMaxLines: 2,
                        hintText: l10n.formMailPlaceholder,
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
                Text(l10n.formLocationText),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.location.value,
                      focusNode: focusNodeLocation,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.formLocationPlaceholder,
                        errorText: state.location.invalid
                            ? '''Please enter your location.'''
                            : null,
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
                Text(l10n.formPositionText),
                const SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: TextFormField(
                      initialValue: state.position.value,
                      focusNode: focusNodePosition,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.formPositionPlaceholder,
                        errorText: state.position.invalid
                            ? '''Please enter your position.'''
                            : null,
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
