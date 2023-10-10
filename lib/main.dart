import 'dart:math';

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List content = [
    "C",
    "delete",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "cos",
    "*",
    "4",
    "5",
    "6",
    "sin",
    "-",
    "1",
    "2",
    "3",
    "pi",
    "+",
    "%",
    "0",
    ".",
    "ans",
    "=",
  ];
  List expressionn = [];
  String opp = "";

  late num results = 0;

  @override
  void setState(VoidCallback fn) {
    opp;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: Text(
                  "$opp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(2, 2))
                      ]),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 50,
                  child: Text(
                    "=$results",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        shadows: [
                          Shadow(
                              color: Colors.orange,
                              blurRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                  )),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                  itemCount: content.length,
                  itemBuilder: (context, j) {
                    if (j == 1) {
                      return MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (!opp.isEmpty) {
                              if (opp.length == 1) {
                                List<String> c = opp.split(
                                    ""); // ['a', 'a', 'a', 'b', 'c', 'd']
                                c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
                                opp = c.join();
                                results = 0;
                              } else {
                                List<String> c = opp.split(
                                    ""); // ['a', 'a', 'a', 'b', 'c', 'd']
                                c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
                                opp = c.join();
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.backspace_outlined,
                          size: 30,
                          color: Colors.orange,
                        ),
                      );
                    } else {
                      if (j == 0 ||
                          j == 1 ||
                          j == 2 ||
                          j == 3 ||
                          j == 4 ||
                          j == 9 ||
                          j == 14 ||
                          j == 19 ||
                          j == 24) {
                        return MaterialButton(
                          color: Colors.orange,
                          onPressed: () {
                            if (j == 0) {
                              setState(() {
                                results = 0;
                                opp = "";
                              });
                            } else if (j == 24) {
                              try {
                                setState(() {
                                  List exp = [opp];
                                  print(opp);
                                  for (final expression in exp) {
                                    results = expression.toString().interpret();
                                  }
                                });
                              } on Exception catch (e) {
                                e.toString();
                              }
                            } else {
                              setState(() {
                                opp = opp + content[j];
                              });
                            }
                          },
                          child: Text(
                            "${content[j]}",
                            style: const TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        );
                      } else if (j == 8 || j == 13 || j == 23 || j == 18) {
                        return MaterialButton(
                          onPressed: () {
                            if (j == 23) {
                              setState(() {
                                try {
                                  setState(() {
                                    String an = "ans";
                                    an = results.toString();
                                    opp = an;
                                    List exp = [opp];
                                    for (final expression in exp) {
                                      results =
                                          expression.toString().interpret();
                                    }

                                    print(an);
                                  });
                                } on Exception catch (e) {
                                  e.toString();
                                }
                              });
                            } else if (j == 18) {
                              setState(() {
                                opp = opp + content[j];
                              });
                            } else
                              setState(() {
                                opp = opp + content[j] + "(";
                              });
                          },
                          child: Text(
                            "${content[j]}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        );
                      } else
                        return MaterialButton(
                          onPressed: () {
                            if (j == 19) {
                              setState(() {
                                opp = opp + content[j];
                              });
                            } else {
                              setState(() {
                                opp = opp + content[j];
                              });
                            }
                          },
                          height: 10,
                          child: Text(
                            "${content[j]}",
                            style: const TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        );
                    }
                  }),
            )
          ],
        ));
  }
}

class Operation extends ChangeNotifier {
  String opp = "0";

  adding() {}
}
