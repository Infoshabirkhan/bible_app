import 'package:bible_app/Controllers/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_books_cubit/bible_books_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'Views/authentication_screen/login_screen/login_screen.dart';
import 'Views/authentication_screen/signup_screen/sign_up_screen.dart';
import 'Views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await   MobileAds.instance.initialize();

  await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> BottomNavigationCubit(0)),
        BlocProvider(create: (context)=> AuthenticationCubit()),
        BlocProvider(create: (context)=> BibleTaskCubit()),
        BlocProvider(create: (context)=> BibleBooksCubit()),
        BlocProvider(create: (context)=> ChapterCubit()),
      ],
      child: ScreenUtilInit(

        builder: (BuildContext context, Widget? child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser !=null ? BottomNavigationScreen(): LoginScreen(),
        ),
      ),
    );
  }
}

