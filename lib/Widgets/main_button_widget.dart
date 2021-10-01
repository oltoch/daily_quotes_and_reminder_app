import 'package:flutter/material.dart';

import '../Utils/constants.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: kButtonDecoration,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfffcfcfc),
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
