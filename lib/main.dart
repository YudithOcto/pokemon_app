import 'package:flutter/material.dart';
import 'package:pokemon_app/injection_container.dart' as di;
import 'package:pokemon_app/presentation/homepage/home_page.dart';
import 'package:pokemon_app/presentation/homepage/providers/home_providers.dart';
import 'package:pokemon_app/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProviders>(
          create: (_) => HomeProviders(apiProvider: di.singleton()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Pokemon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.routeName,
        routes: routes,
      ),
    );
  }
}
