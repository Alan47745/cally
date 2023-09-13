import 'package:flutter/material.dart';

const primaryPurple = Color(0xff7B65D6);
const primaryGrey = Color(0xffD7D6D6);
void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void navigatePop(BuildContext context) {
  Navigator.pop(context);
}
