

import 'package:osm_flutter/app/auth/repository/auth_repository.dart';
import 'package:osm_flutter/app/auth/view_model/auth_provider.dart';
import 'package:osm_flutter/app/lending/repo/lending_repository.dart';
import 'package:osm_flutter/app/lending/view_model/lending_provider.dart';
import 'package:osm_flutter/app/project_tab/repository/project_repository.dart';
import 'package:osm_flutter/app/project_tab/view_model/project_provider.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/timer/timer_notifier.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';
import 'package:osm_flutter/usecases/home/home_usecases.dart';
import 'package:osm_flutter/usecases/project/project_usecases.dart';
import 'package:osm_flutter/usecases/task/task_usecases.dart';
import 'package:provider/provider.dart';
import 'app/home_tab/repository/home_repository.dart';
import 'app/home_tab/view_model/home_provider.dart';
import 'app/tab/view_model/tab_bar_provider.dart';
import 'app/tab/view_model/timer_provider.dart';

class AppProviders{

  /// usecases
  static var authUseCase = AuthUseCases();
  static var homeUseCase = HomeUseCases();
  static var taskUseCase = TaskUseCases();
  static var projectUSeCase = ProjectUSeCases();

  /// Repository
  static var authRepo = AuthRepository(authUSeCases: authUseCase);
  static var homeRepo = HomeRepository(homeUseCases: homeUseCase);
  static var taskRepo = TaskRepository(taskUseCases: taskUseCase);
  static var projectRepo = ProjectRepository(projectUseCases: projectUSeCase);

  /// Providers
  static get mainDashboardProvider => ChangeNotifierProvider(create: (context) => TabBarProvider());
  static get timeProvider => ChangeNotifierProvider(create: (context) => TimeProvider());
  static get timerProvider => ChangeNotifierProvider(create: (context) => TimerNotifier());
  static get authProvider => ChangeNotifierProvider(create: (context) => AuthProvider(authRepository: authRepo));
  static get homeProvider => ChangeNotifierProvider(create: (context) => HomeProvider(homeRepository: homeRepo ));
  static get taskProvider => ChangeNotifierProvider(create: (context) => TaskProvider(taskRepository: taskRepo));
  static get lendingProvider => ChangeNotifierProvider(create: (context) => LendingProvider(lendingRepository: LendingRepository()),);
  static get projectProvider => ChangeNotifierProvider(create: (context) => ProjectProvider(projectRepository: projectRepo),);


}

