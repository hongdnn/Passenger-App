import 'package:flutter/material.dart';

class MockNotificationSupperAppPage extends StatelessWidget {
  const MockNotificationSupperAppPage({Key? key}) : super(key: key);
  static const String routeName = '/mockNotificationSupperAppPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MockNotificationSupperAppPage'),
      ),
    );
  }
}
