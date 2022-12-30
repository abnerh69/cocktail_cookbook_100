import 'dart:ui';

import 'package:flutter/material.dart';

Widget frostedEdged(Widget child) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), child: child));
}

Widget listCard(BuildContext context, String title, List<String> list) {
  return frostedEdged(Container(
      key: ValueKey<String>(title),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.black12.withOpacity(0.3),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                )),
            const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(color: Colors.white70)),
            Expanded(
                child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(list[index]));
              },
            ))
          ])));
}
