import 'package:flutter/material.dart';

class WAppBackground extends StatefulWidget {
  const WAppBackground({Key? key}) : super(key: key);

  @override
  State<WAppBackground> createState() => _WAppBackgroundState();
}

class _WAppBackgroundState extends State<WAppBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.dstOut),
          image: const AssetImage('assets/images/background.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
