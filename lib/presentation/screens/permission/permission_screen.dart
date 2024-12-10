import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanios_flutter/presentation/providers/providers.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsProvider);

    return ListView(children: [
      CheckboxListTile(
          title: const Text('Camara'),
          subtitle: Text('${permissions.camera}'),
          value: permissions.cameraGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          }),
    ]);
  }
}
