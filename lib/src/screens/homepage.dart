import 'dart:async';
import 'dart:developer';

import 'package:audio_text/main.dart';
import 'package:audio_text/src/providers/ChatProviders.dart';
import 'package:audio_text/src/screens/notification_screen.dart';
import 'package:audio_text/src/screens/money_screen.dart';
import 'package:audio_text/src/screens/report_screen.dart';
import 'package:audio_text/src/screens/inventory_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audio_text/src/ui_component/boss_app_bar.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  final TextEditingController _textEditingController = TextEditingController();

  String recordedAudioString = "";
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  bool isInEditMode = false;
  double inputContainerHeight = 0;
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.wav,
        );
        if (kDebugMode) {
          print('${AudioEncoder.wav.name} supported: $isSupported');
        }
        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      print("path is $path");
      audioPath = path;
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    const InventoryScreen(),
    const MoneyScreen(),
    const NotificationScreen(),
    const ReportScreen(),
  ];

  final TextEditingController _textController = TextEditingController();

  void _addMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        Provider.of<ChatProvider>(context, listen: false).messages.add(message);
      });
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    List<SideMenuItem> sideMenus = [
      SideMenuItem(
        title: 'Dashboard',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Money',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.currency_exchange_outlined),
      ),
      SideMenuItem(
        title: 'Summary',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.table_chart_rounded),
      ),
      SideMenuItem(
        title: 'Document',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.edit_document),
      ),
      SideMenuItem(
        title: 'Exit',
        icon: const Icon(Icons.add),
        onTap: (index, _) {
          log("use log to log something");
        },
      ),
    ];
    return Scaffold(
      appBar: BossAppBar(
        context: context,
        title: "Money Management",
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SideMenu(
                controller: sideMenu,
                alwaysShowFooter: true,
                style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.auto,
                  hoverColor: Colors.blue[100],
                  selectedHoverColor: Colors.blue[100],
                  selectedColor: Colors.blueGrey[300],
                  selectedTitleTextStyle: const TextStyle(color: Colors.white),
                  selectedIconColor: Colors.white,
                  backgroundColor: Colors.blueGrey[50],
                ),
                title: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 150,
                        maxWidth: 150,
                      ),
                      child: const Text(""),
                    ),
                  ],
                ),
                items: sideMenus,
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (index) => sideMenu.changePage(index),
                  controller: pageController,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 120,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 189, 198, 203),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 70,
              child: Container(
                width: 50,
                color: Colors.blueGrey[50],
                child: Container(
                  padding: const EdgeInsets.only(bottom: 1.0),
                  child: IconButton(
                    tooltip: 'Edit',
                    icon: Icon(isInEditMode ? Icons.close : Icons.edit),
                    onPressed: () {
                      log("i m being o pressed again");
                      setState(() {
                        isInEditMode = !isInEditMode;
                        inputContainerHeight = isInEditMode ? 50 : 0;
                      });
                    },
                  ),
                ),
              ),
            ),
            isInEditMode
                ? Positioned(
                    left: 0,
                    right: 0,
                    top: 55,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300), // Animation duration
                      height: inputContainerHeight,
                      // height: 50,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'type here...',
                                    contentPadding: const EdgeInsets.all(16.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 1),
                              height: 40,
                              width: 50,
                              child: IconButton(
                                icon: const Icon(Icons.send_sharp),
                                onPressed: () {
                                  _addMessage(_textEditingController.text);
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      (_recordState != RecordState.stop) ? _stop() : _start();

                      if (audioPath != null && audioPath!.isNotEmpty && _recordState == RecordState.record) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Audio path: $audioPath"),
                          backgroundColor: const Color.fromARGB(255, 33, 34, 33),
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(5),
                        ));
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 6, color: Colors.black),
                          color: _recordState != RecordState.stop ? Colors.red : const Color.fromARGB(255, 67, 67, 67),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/record.png",
                              width: 30,
                            ),
                            Text(
                              "Speech",
                              style: GoogleFonts.poppins(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
