import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:task_interview/cubit/image_pick/image_pick_cubit.dart';
import 'package:task_interview/cubit/student_list/student_list_cubit.dart';
import 'package:task_interview/page_name/page_name.dart';
import 'package:task_interview/route/page_route.dart';
import 'package:task_interview/service/api_service.dart';

ApiRepository apiRepository = ApiRepository();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: studentListScreen, 
        routes: appRoutes, 
        builder: (context, child) {
          return LoaderOverlay(
            child:
                child ?? Container(), 
          );
        },
      ),
    );
  }
}

final providers = [
  BlocProvider<StudentListCubit>(
    create: (context) => StudentListCubit(),
  ),
  BlocProvider<ImageCubit>(
    create: (context) => ImageCubit(),
  ),
  BlocProvider<GenderCubit>(
    create: (context) => GenderCubit(),
  ),
];
