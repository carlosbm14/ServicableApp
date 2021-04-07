import 'package:appservicable/src/viewmodels/dniViewModel.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:appservicable/src/viewmodels/formulariosViewModel.dart';
import 'package:appservicable/src/viewmodels/initialViewModel.dart';
import 'package:appservicable/src/viewmodels/loginViewModel.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/viewmodels/registroViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<EstadoCuentaViewModel>(() => EstadoCuentaViewModel());
  sl.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  sl.registerLazySingleton<RegistroViewModel>(() => RegistroViewModel());
  sl.registerLazySingleton<PromosViewModel>(() => PromosViewModel());
  sl.registerLazySingleton<ProgramacionViewModel>(() => ProgramacionViewModel());
  sl.registerLazySingleton<DniViewModel>(() => DniViewModel());
  sl.registerLazySingleton<ParrillaHomeViewModel>(() => ParrillaHomeViewModel());
  sl.registerLazySingleton<InitialViewModel>(() => InitialViewModel());
  sl.registerLazySingleton<FormularioViewModel>(() => FormularioViewModel());
}