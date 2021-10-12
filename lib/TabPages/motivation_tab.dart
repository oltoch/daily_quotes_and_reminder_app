import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:daily_quotes_and_reminder_app/Services/networking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MotivationTab extends StatefulWidget {
  @override
  State<MotivationTab> createState() => _MotivationTabState();
}

class _MotivationTabState extends State<MotivationTab> {
  static String quote = '';
  static String author = '';
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('images/picture.png'),
                  fit: BoxFit.fill,
                ),
                backgroundBlendMode: BlendMode.src),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xff202020),
                  Colors.transparent
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.01, 0.5, 1],
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Quote of the day',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 48, color: Colors.white),
                      softWrap: true,
                      maxLines: null,
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Color(0x55ffffff),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x55ffffff),
                                  Color(0x33000000),
                                ],
                                stops: [0.01, 0.99],
                              ),
                            ),
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        fontSize: 28, color: Colors.white)),
                                textAlign: TextAlign.center,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  pause: Duration(seconds: 5),
                                  animatedTexts: [
                                    TypewriterAnimatedText(quote),
                                    TypewriterAnimatedText(author),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  getQuote();
                                },
                                child: Text('Press me')),
                            SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: () {}, child: Text('Me too'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      getQuote();
                    },
                    child: Text('Press me'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getQuote() async {
    String url = 'https://quotable.io/random';
    //String url = 'https://type.fit/api/quotes';
    var response = await NetworkHelper(url: url).getData();
    if (response == 'failed') {
      return;
    }
    // Map map = {};
    // for (int i = 0; i < 100; i++) {
    //   map[response[i]['author']] = response[i]['text'];
    // }
    // print(map.values.elementAt(64));
    // var box = Hive.box('quote');
    // box.putAll(map);
    print(response['content']);
    print(response['tags']);
    // print(response[65]['author']);
    // print(response[65]['text']);

    // setState(() {
    //   quote = response[i]['text'];
    //   author = 'Author:\n' + response[i]['author'];
    //   i++;
    // });
  }
}
