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
  ];
}
