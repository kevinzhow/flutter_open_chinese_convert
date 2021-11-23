import 'package:flutter/material.dart';
import 'package:flutter_open_chinese_convert/flutter_open_chinese_convert.dart';
import 'package:twicon/twicon.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  String _original = '鼠标里面的硅二极管坏了，导致光标分辨率降低。\n滑鼠裡面的矽二極體壞了，導致游標解析度降低。';
  String _converted = '';

  @override
  void initState() {
    super.initState();
    _convert();
  }

  Future<void> _convert() async {
    var text = _original;
    var option = ChineseConverter.allOptions[_index];
    var result = await ChineseConverter.convert(
      text,
      option,
      inBackground: true,
    );
    setState(() => _converted = result);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Row(
            children: <Widget>[
              Icon(TaiwanIcons.tapioca_milk_tea),
              const Text('Open Chinese Convert'),
            ],
          )),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildMenu(context),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Original:',
                      style: Theme.of(context).textTheme.headline3),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_original),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Conveted:',
                      style: Theme.of(context).textTheme.headline3),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_converted ?? ''),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenu(BuildContext context) => PopupMenuButton<int>(
      elevation: 2,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(ChineseConverter.allOptions[_index].chineseDescription,
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ),
      onSelected: (i) {
        _index = i;
        _convert();
      },
      itemBuilder: (context) => List.of(ChineseConverter.allOptions
          .asMap()
          .map((i, x) => MapEntry(
              i,
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 40,
                        child: i == _index ? Icon(Icons.check) : Container()),
                    Expanded(
                        child: Text(x.chineseDescription,
                            style: TextStyle(fontSize: 12.0))),
                  ],
                ),
                value: i,
              )))
          .values));
}
