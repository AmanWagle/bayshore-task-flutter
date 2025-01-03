import 'package:bayshore_task_frontend/app.dart';
import 'package:bayshore_task_frontend/repository/auth_repository.dart';
import 'package:bayshore_task_frontend/repository/book_repository.dart';
import 'package:bayshore_task_frontend/services/api_service.dart';
import 'package:bayshore_task_frontend/services/shared_preferences_service.dart';
import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/view_model/auth_view_model.dart';
import 'package:bayshore_task_frontend/view_model/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final apiService = ApiService(appURL);
  final bookRepository = BookRepository(apiService);
  final authRepository = AuthRepository(apiService, SharedPreferencesService());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookViewModel(bookRepository)),
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository)),
      ],
      child: MyApp(),
    ),
  );
}
