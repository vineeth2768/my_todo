import 'package:flutter/material.dart';
import 'package:my_todo/Provider/provider_db.dart';
import 'package:my_todo/Provider/theme_provider.dart';
import 'package:my_todo/pages/todo_home.dart';
import 'package:my_todo/theme.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderDB>(
          create: (BuildContext context) => ProviderDB()..init(),
        ),
        // You can add more providers here if needed
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeServiceProvider(),
        ),
      ],
      child: Consumer<ThemeServiceProvider>(
        builder: (context, themeService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode:
                themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const TodoView(),
          );
        },
      ),
    );
  }
}
