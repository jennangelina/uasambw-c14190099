import 'package:c14190099_01/dataclass.dart';
import 'package:c14190099_01/pages/detaildata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../dbservice.dart';

class LikedDataPage extends StatefulWidget {
  const LikedDataPage({Key? key}) : super(key: key);

  @override
  State<LikedDataPage> createState() => _LikedDataPageState();
}

class _LikedDataPageState extends State<LikedDataPage> {
  int _jumlah = 0;

  TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    _searchCtrl.addListener(onSearch);
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return Database.getData(_searchCtrl.text);
  }

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
            TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('ERROR');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot _data = snapshot.data!.docs[index];
                        _jumlah = snapshot.data!.docs.length;
                        return Dismissible(
                          key: Key(_data['title']),
                          background: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            color: Colors.grey,
                          ),
                          secondaryBackground: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Text("Unlike"),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              Database.deleteData(
                                  judulHapus: _data['title']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Item unliked')));
                              return false;
                            } else {
                              return false;
                            }
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(_data['title']),
                              leading: Image.network(_data['thumbnail']),
                              subtitle: Text(_data['pubDate']),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailDataPage(
                                            link: _data['link'],
                                            title: _data['title'],
                                            pubDate: _data['pubDate'],
                                            description: _data['description'],
                                            thumbnail: _data['thumbnail'])));
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.0),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
