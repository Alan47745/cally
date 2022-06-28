// ignore_for_file: unused_local_variable, file_names

import 'package:cally/theme/my_theme.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class CallLogs {
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  getAvatar(CallType callType, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    switch (callType) {
      case CallType.outgoing:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.green,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.cardColor
              : MyTheme.lightTheme.cardColor,
          child: const Icon(Icons.call_made_rounded),
        );
      case CallType.missed:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.blue,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.cardColor
              : MyTheme.lightTheme.cardColor,
          child: const Icon(Icons.call_missed),
        );
      case CallType.rejected:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.red,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.cardColor
              : MyTheme.lightTheme.cardColor,
          child: const Icon(Icons.call_end),
        );
      case CallType.incoming:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.black,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.cardColor
              : MyTheme.lightTheme.cardColor,
          child: const Icon(Icons.call_received_rounded),
        );
      default:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.green,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.cardColor
              : MyTheme.lightTheme.cardColor,
          child: const Icon(Icons.call),
        );
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs() async {
    return await CallLog.get();
  }

  String formatDate(DateTime dt) {
    return intl.DateFormat('d-MMM-y  H:m:s').format(dt);
  }

  getTitle(CallLogEntry entry, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (entry.name == null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${entry.number}",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins Regular',
              color: themeProvider.isDarkMode == true
                  ? MyTheme.darkTheme.primaryColor
                  : MyTheme.lightTheme.primaryColor,
            ),
          ),
        ],
      );
    }
    if (entry.name!.isEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${entry.number}",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins Regular',
              color: themeProvider.isDarkMode == true
                  ? MyTheme.darkTheme.primaryColor
                  : MyTheme.lightTheme.primaryColor,
            ),
          ),
        ],
      );
    } else {
      return Text(
        "${entry.name}",
        style: TextStyle(
          fontSize: 16.0,
          // fontFamily: entry.name!.contains(RegExp('[^A-Za-z]'))
          //     ? 'Poppins Regular'
          //     : 'Tajawal',
          fontFamily: 'Poppins Regular',
          color: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.primaryColor
              : MyTheme.lightTheme.primaryColor,
        ),
      );
    }
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    // if (d1.inSeconds > 0) {
    //   formatedDuration += d1.inSeconds.toString(). + "s";
    // }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
