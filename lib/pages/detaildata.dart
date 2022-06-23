import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailDataPage extends StatefulWidget {
  final String link;
  final String title;
  final String pubDate;
  final String description;
  final String thumbnail;

  const DetailDataPage(
      {Key? key,
      required this.link,
      required this.title,
      required this.pubDate,
      required this.description,
      required this.thumbnail})
      : super(key: key);

  @override
  State<DetailDataPage> createState() => _DetailDataPageState();
}

class _DetailDataPageState extends State<DetailDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UAS AMBW C14190099'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 15,),
              Text(widget.link, style: TextStyle(color: Color.fromARGB(125, 0, 0, 0), fontSize: 14)),
              SizedBox(height: 15,),
              Text(widget.pubDate, style: TextStyle(fontStyle:FontStyle.italic, color: Color.fromARGB(125, 0, 0, 0), fontSize: 14)),
              SizedBox(height: 20,),
              Image.network(widget.thumbnail),
              SizedBox(height: 20,),
              Text(widget.description, style: TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
