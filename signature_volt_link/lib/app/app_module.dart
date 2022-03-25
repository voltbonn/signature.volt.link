import 'package:flutter_modular/flutter_modular.dart';

import '../signature/signature.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  // ignore: overridden_fields
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  // ignore: overridden_fields
  final List<ModularRoute> routes = [
    ChildRoute<SignaturePage>(Modular.initialRoute,
        child: (_, __) => const SignaturePage()),
    ChildRoute<SignaturePage>(
      '/:member_name/:mail_address/:location/:position',
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 500),
      child: (_, args) => SignaturePage(
        memberName: args.params['member_name'].toString(),
        mailAddress: args.params['mail_address'].toString(),
        location: args.params['location'].toString(),
        position: args.params['position'].toString(),
      ),
    ),
  ];
}
