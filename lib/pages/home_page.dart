import 'dart:convert';

import 'package:ai_voice/pages/radio.dart';
import 'package:ai_voice/utils/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio>? radios;
  @override
  void initState() {
    super.initState();
    fetchRadius();
  }

  fetchRadius() async {
    final radioJson = await rootBundle.loadString('assets/radio.json');
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    print(radios!.length);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Shimmer(
          gradient: RadialGradient(colors: [colour.red_col, colour.kgrey_col]),
          child: Text(
            'Radio app',
            style: const TextStyle(
              fontSize: 50,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 3),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [colour.kblue_col, colour.kgreen_col],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd),
            ),
          ),
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: radios!.length, // cant write final radios.length;
              itemBuilder: (context, index) {
                final rad =
                    radios![index]; // cant write final rad = radios[index];
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(rad.image))),
                  child: Stack(children: []),
                );
              }),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
    );
  }
}
