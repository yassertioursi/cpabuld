import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/locker/data/models/locker_model.dart';
import 'features/locker/data/datasources/locker_local_datasource.dart';
import 'features/locker/data/repositories/locker_repository_impl.dart';
import 'features/locker/domain/usecases/create_locker.dart';
import 'features/locker/domain/usecases/get_lockers.dart';
import 'features/locker/domain/usecases/unlock_locker.dart';
import 'features/locker/presentation/pages/home_page.dart';
import 'features/locker/presentation/provider/locker_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LockerModelAdapter());
  await Hive.openBox<LockerModel>(LockerLocalDatasource.boxName);

  final datasource = LockerLocalDatasource();
  final repository = LockerRepositoryImpl(datasource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LockerProvider(
            createLocker: CreateLocker(repository),
            getLockers: GetLockers(repository),
            unlockLocker: UnlockLocker(repository),
          )..loadLockers(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CPAbuild',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
