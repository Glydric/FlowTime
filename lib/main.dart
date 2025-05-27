import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flowtime/models/clock_model.dart';
import 'package:flowtime/models/profile_model.dart';
import 'package:flowtime/screens/home_screen.dart';
import 'package:flowtime/services/theme_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProxyProvider(
        create: (context) => ProfilesProvider(),
        update: (context, storage, previous) => previous ?? ProfilesProvider(),
      ),
      ChangeNotifierProvider(create: (_) => ClockModel()),
    ],
    child: Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => MaterialApp(
        title: 'FlowTime',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'ConcertOne',
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'ConcertOne',
        ),
        themeMode: themeProvider.themeMode,
        home: const HomeScreen(),
      ),
    ),
  );
}
