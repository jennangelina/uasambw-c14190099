import 'package:c14190099_01/apiservice.dart';
import 'package:c14190099_01/dataclass.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'FIREBASE CRUD',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // data static
  

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
        title: Text('UAS AMBW'),
      ),
      body: Container(
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
                          child: Icon(Icons.check),
                        ),
                        secondaryBackground: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(Icons.delete),
                        ),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        onDismissed: (direction) {
                          //deleteData(isiData[index].cid);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(isiData[index].cTitle),
                            leading: Image.network(isiData[index].cThumbnail),
                            subtitle: Text(isiData[index].cPubDate),
                            onTap: () {},
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
    );
  }
}
