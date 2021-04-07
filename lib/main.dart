import 'package:appservicable/src/services/locator.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/viewmodels/dniViewModel.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:appservicable/src/viewmodels/formulariosViewModel.dart';
import 'package:appservicable/src/viewmodels/initialViewModel.dart';
import 'package:appservicable/src/viewmodels/loginViewModel.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/viewmodels/registroViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appservicable/src/pages/home_page.dart';
import 'package:appservicable/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PersistenceLocal();
  await prefs.initPrefs();
  setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) //orientacion vetical
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  final pref = new PersistenceLocal();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<EstadoCuentaViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<LoginViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<RegistroViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<PromosViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<ProgramacionViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<DniViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<ParrillaHomeViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<InitialViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<FormularioViewModel>()),
      ],
          child: MaterialApp(
        navigatorObservers: [
    FirebaseAnalyticsObserver(analytics: analytics),
  ],
        title: 'App Servicable',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: (pref.email=='')? '/': 'parrillaHome',
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => HomePage()
          );
        },
      ),
    );
  }
}