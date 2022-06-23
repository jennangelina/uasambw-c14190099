import 'package:c14190099_01/apiservice.dart';
import 'package:c14190099_01/dataclass.dart';
import 'package:c14190099_01/pages/detaildata.dart';
import 'package:c14190099_01/pages/likeddata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dbservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'UAS AMBW C14190099',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Service serviceAPI = Service();
  late Future<List<cBerita>> listBerita;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBerita = serviceAPI.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UAS AMBW C14190099'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(20),
                child: FutureBuilder<List<cBerita>>(
                  future: listBerita,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<cBerita> isiData = snapshot.data!;
                      return ListView.builder(
                        itemCount: isiData.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: Key(isiData[index].cTitle),
                              background: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                color: Colors.green,
                                child: Text("Like"),
                              ),
                              secondaryBackground: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Text("Unlike"),
                              ),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  final newData = cBerita(
                                      cLink: isiData[index].cLink,
                                      cTitle: isiData[index].cTitle,
                                      cPubDate: isiData[index].cPubDate,
                                      cDescription: isiData[index].cDescription,
                                      cThumbnail: isiData[index].cThumbnail);
                                  Database.addData(item: newData);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Item liked')));
                                  return false;
                                } else {
                                  Database.deleteData(
                                      judulHapus: isiData[index].cTitle);
                                  return false;
                                }
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(isiData[index].cTitle),
                                  leading:
                                      Image.network(isiData[index].cThumbnail),
                                  subtitle: Text(isiData[index].cPubDate),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailDataPage(
                                                    link: isiData[index].cLink,
                                                    title:
                                                        isiData[index].cTitle,
                                                    pubDate: isiData[index].cPubDate,
                                                    description:
                                                        isiData[index].cDescription,
                                                    thumbnail:
                                                        isiData[index].cThumbnail,)));
                                  },
                                ),
                              ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                )),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LikedDataPage();
              }));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(45),
            ),
            child: Text('Halaman Like'),
          )
        ],
      ),
    );
  }
}
