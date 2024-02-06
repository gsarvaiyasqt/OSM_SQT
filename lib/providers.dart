

import 'package:osm_flutter/app/auth/repository/auth_repository.dart';
import 'package:osm_flutter/app/auth/view_model/auth_provider.dart';
import 'package:osm_flutter/app/lending/repo/lending_repository.dart';
import 'package:osm_flutter/app/lending/view_model/lending_provider.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';
import 'package:osm_flutter/usecases/task/task_usecases.dart';
import 'package:provider/provider.dart';

import 'app/tab/view_model/tab_bar_provider.dart';

class AppProviders{


  // usecases
  static var authUseCase = AuthUseCases();
  static var taskUseCase = TaskUseCases();



  // Providers

  static var authRepo = AuthRepository(authUSeCases: authUseCase);
  static var taskRepo = TaskRepository(taskUseCases: taskUseCase);

  static get mainDashboardProvider => ChangeNotifierProvider(create: (context) => TabBarProvider());
  static get authProvider => ChangeNotifierProvider(create: (context) => AuthProvider(authRepository: authRepo));
  static get taskProvider => ChangeNotifierProvider(create: (context) => TaskProvider(taskRepository: taskRepo));
  static get lendingProvider => ChangeNotifierProvider(create: (context) => LendingProvider(lendingRepository: LendingRepository()),);

}