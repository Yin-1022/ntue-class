import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constant.dart';
import 'note_database.dart';
import 'color_data.dart';
import 'dart:math';

int randomNumber()
{
  return Random().nextInt(4);
}

void removeNote(int index)
{
  textData.removeAt(index);
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      theme: ThemeData.dark(),
      home: Scaffold
      (
        floatingActionButton: FloatingActionButton
        (
            onPressed: ()
            {
              setState(()
              {
                textData.add({"title": "a", "content" : "b"});
              });
            },
            child: Icon(Icons.add),
        ),
        appBar: AppBar
        (
          title: const Text("Flutter Week 2",style: TextStyle(fontSize: 30),),
          centerTitle: true,
        ),
        body: Row
        (
          children:
          [
            Expanded(
              child: Container
              (
                color: const Color(0xffeabcdd),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder
                  (
                    itemCount : textData.length,
                    itemBuilder: (context, index)
                    {
                      final task = textData[index];
                      return CardWidget(title: task['title'], content: task["content"], index:index ,remove: ()
                      {
                        setState(()
                        {
                          removeNote(index);
                        });
                      });
                    },
                  )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class CardWidget extends StatelessWidget
{
  final String? title;
  final String? content;
  final int index;
  final VoidCallback remove;


  const CardWidget({
    super.key,
    required this.title,
    required this.content,
    required this.index,
    required this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Container
    (
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration
      (
          color: Color(int.parse(colorTheme[randomNumber()])),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? "default", style: kTitleTextStyle),
              IconButton
              (
                  onPressed: (){remove();},
                  icon: FaIcon(FontAwesomeIcons.trash, color: Colors.grey.shade700,),
              ),
            ],
          ),
          Text(content ?? "default", style: kContentTextStyle)
        ],
      ),
    );
  }
}