import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _light = true;

  @override //appကိုပထမဆုံးစဖွင့်ဖွင့်ချင်းအလုပ်လုပ်
  initState() {
    super.initState();
    _light = true;
    //print("App Start");
    _getThemeData();
  }

  _getThemeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getBool("theme"); //setbool လုပ်ထားတာကိုပြန်ယူ
    // print(data);
    //prefs.remove("theme");

    if (data == null) {
      prefs.setBool("theme", true);
    } else if (data == false) {
      setState(() {
        _light = data;
      });
    }
  }

  _save() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("theme", _light); //setbool ကdata သတ်မှတ်တာ
      print("Save Success");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FLutter UI",
        theme: _light ? lightTheme : darkTheme,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Flutter UI"),
          ),
          body: Center(
            child: Column(
              children: [
                Switch(
                  value: _light,
                  onChanged: (c) {
                    //ပြောင်းပြန်လုပ်ပေးတာ onchangeက
                    setState(() {
                      //state ပြောင်းလို့ Light/darkဆိုပြီး
                      _light = c;
                      _save();
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var data = prefs.getBool("theme");
                      print(data);
                    },
                    child: Text("Click me"))
              ],
            ),
          ),
        ));
  }
}
