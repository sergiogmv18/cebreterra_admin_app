import 'package:cebreterra/cebreterra.dart';
import 'package:cebreterra/features/branch/controller/branch_controller.dart';
import 'package:cebreterra/features/contact/controllers/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactController()),
        ChangeNotifierProvider(create: (context) => BranchController()),
      ],
      child: const Cebreterra(),
    )
  );
}

