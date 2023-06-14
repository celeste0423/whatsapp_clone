import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clone/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/feature/home/pages/call_home_page.dart';
import 'package:whatsapp_clone/feature/home/pages/chat_home_page.dart';
import 'package:whatsapp_clone/feature/home/pages/status_home_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Timer timer;

  updateUserPresence() {
    ref.read(authControllerProvider).updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    timer = Timer.periodic(
      //1분마다 setState가 계속해서 호출됨
      const Duration(minutes: 1),
      (timer) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    //위젯이 파괴되었을 때 수행
    timer.cancel();
    super.dispose(); //백그라운드에서 계속 타이머 시행되지 않도록
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
          elevation: 1,
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatHomePage(),
            StatusHomePage(),
            CallHomePage(),
          ],
        ),
      ),
    );
  }
}
