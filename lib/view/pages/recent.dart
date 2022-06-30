// ignore_for_file: unused_field

import 'package:call_log/call_log.dart';
import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/callLogs.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Recent extends StatefulWidget {
  @override
  _RecentState createState() {
    return _RecentState();
  }
}

class _RecentState extends State<Recent> with WidgetsBindingObserver {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  CallLogs cl = CallLogs();

  Future<Iterable<CallLogEntry>>? logs;

  Future<void> checkPermissionPhone() async {
    if (await Permission.phone.request().isGranted) {
      cl.getCallLogs();
    } else {
      await Permission.phone.request();
    }
  }

  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkPermissionPhone().then((value) {
      setState(() {
        logs = cl.getCallLogs().then((value) {
          if (value.isEmpty) {
            setState(() {
              isEmpty = true;
            });
          }
          return value;
        });
      });
    }).catchError((error) {
      debugPrint(error);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      setState(() {
        logs = cl.getCallLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: DrawerPage(),
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        backgroundColor: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.appBarTheme.backgroundColor
            : MyTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0.0,
        toolbarHeight: 60.0,
        title: Text(
          "${AppLocalization.of(context)?.getTranslatedValue('recentTitle')}",
        ),
        titleTextStyle: TextStyle(
          fontFamily: themeProvider.font,
          fontSize: 16.0,
        ),
        leading: Builder(builder: (context) {
          return Transform(
            alignment: Alignment.center,
            transform: CacheHelper.getData(key: 'languageCode') == 'ar'
                ? Matrix4.rotationY(math.pi)
                : Matrix4.rotationY(0),
            child: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)?.open();
              },
              icon: SvgPicture.asset(
                'assets/img/drawer.svg',
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
      body: RefreshIndicator(
        color: primaryPurple,
        strokeWidth: 3.0,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() {
            logs = cl.getCallLogs();
          });
        },
        child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSwatch(accentColor: primaryPurple),
          ),
          child: isEmpty == true
              ? Center(
                  child: Text(
                    "${AppLocalization.of(context)?.getTranslatedValue('noCall')}",
                    style: TextStyle(
                      fontFamily: themeProvider.font,
                    ),
                  ),
                )
              : Column(
                  children: [
                    FutureBuilder(
                        future: logs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Iterable<CallLogEntry> entries =
                                snapshot.data as Iterable<CallLogEntry>;
                            return Expanded(
                              child: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                clipBehavior: Clip.none,
                                itemBuilder: (context, index) {
                                  final themeProvider =
                                      Provider.of<ThemeProvider>(context);
                                  return GestureDetector(
                                    child: ListTile(
                                      leading: cl.getAvatar(
                                          entries.elementAt(index).callType!,
                                          context),
                                      title: cl.getTitle(
                                          entries.elementAt(index), context),
                                      subtitle: Text(
                                        cl.formatDate(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    entries
                                                        .elementAt(index)
                                                        .timestamp!)) +
                                            "\n" +
                                            cl.getTime(entries
                                                .elementAt(index)
                                                .duration!),
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: themeProvider.isDarkMode ==
                                                  true
                                              ? MyTheme.darkTheme.primaryColor
                                              : MyTheme.lightTheme.primaryColor,
                                        ),
                                      ),
                                      isThreeLine: true,
                                      trailing: IconButton(
                                          icon: const Icon(Icons.phone),
                                          color: Colors.green,
                                          onPressed: () {
                                            cl.call(entries
                                                .elementAt(index)
                                                .number!);
                                          }),
                                    ),
                                  );
                                },
                                itemCount: entries.length,
                              ),
                            );
                          } else {
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryPurple,
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
        ),
      ),
    );
  }
}
