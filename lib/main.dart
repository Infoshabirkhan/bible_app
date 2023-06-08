import 'package:bible_app/Controllers/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_books_cubit/bible_books_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Controllers/Cubits/add_new_book_cubit/add_new_book_cubit.dart';
import 'Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import 'Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'Controllers/Cubits/chapter_notes_cubit/chapter_notes_cubit.dart';
import 'Controllers/Cubits/default_book_cubit/default_book_cubit.dart';
import 'Views/authentication_screen/login_screen/login_screen.dart';
import 'Views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseCrashlytics.instance.crash();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavigationCubit(0)),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => DefaultBookCubit()),
        BlocProvider(create: (context) => BibleTaskCubit()),
        BlocProvider(create: (context) => BibleBooksCubit()),
        BlocProvider(create: (context) => ChapterCubit()),
        BlocProvider(create: (context) => AddNewBookCubit()),
        BlocProvider(create: (context) => BookListCubit([])),
        BlocProvider(create: (context) => ChapterNotesCubit()),
      ],
      child: ScreenUtilInit(

        builder: (BuildContext context, Widget? child) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(

                useMaterial3: true,
                brightness: Brightness.dark,
                colorSchemeSeed: Colors.blue,
              ),
              home: FirebaseAuth.instance.currentUser != null
                  ? const BottomNavigationScreen()
                  : const LoginScreen(),
            ),
      ),
    );
  }
}

