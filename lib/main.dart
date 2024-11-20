import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanios_flutter/config/config.dart';
import 'package:miscelanios_flutter/presentation/providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  //Un mixin permite agregar funcionalidades adicionales a una clase sin heredar directamente de otra clase.
  //con with WidgetsBindingObserver, podemos estar observando la instancia de la aplicacion

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).update((state) => state);
    print('state==>$state');
    /*
     resumed: Paso de estar en segundo plano a estar en primer plano.
     inactive: El estado de la aplicación no está activo y no está recibiendo eventos.
    paused: La aplicación está en segundo plano y no está recibiendo eventos.
    detached: La aplicación se cerró. 

    */
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
