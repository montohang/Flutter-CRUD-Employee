import 'package:flutter/material.dart';
import 'package:flutter_employee_crud/pages/pages.dart';
import 'package:flutter_employee_crud/providers/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Employee(),
      ),
    );
  }
}
