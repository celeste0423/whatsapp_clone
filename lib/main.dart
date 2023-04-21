import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/routes/routes.dart';
import 'package:whatsapp_clone/common/theme/dark_theme.dart';
import 'package:whatsapp_clone/common/theme/light_theme.dart';
import 'package:whatsapp_clone/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/feature/home/pages/home_page.dart';
import 'package:whatsapp_clone/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_clone/firebase_options.dart';

void main() async {
  //스플래시 스크린이 다 로딩될때까지 계속 켜져있게 함
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //꼭 위의 줄을 추가해야 실행됨
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Me',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      //시스템의 다크/라이트 모드 세팅을 가져옴
      // home: ContactPage(),
      home: ref.watch(userInfoAuthProvider).when(
        data: (user) {
          //데이터 로딩이 끝나면 스클래시 스크린 제거
          FlutterNativeSplash.remove();
          if (user == null) return const WelcomePage();
          return const HomePage();
        },
        error: (error, trace) {
          return const Scaffold(
              body: Center(child: Text('Something wrong happened!')));
        },
        loading: () {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute, //라우팅
    );
  }
}
