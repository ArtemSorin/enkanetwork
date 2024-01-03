import 'dart:async';

import 'package:enkanetwork/screens/list.dart';
import 'package:flutter/material.dart';

import 'colors/colors.dart';
import 'constants/constants.dart';
import 'database/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final StreamController<List<Map<String, dynamic>>> myController =
      StreamController<List<Map<String, dynamic>>>();

  final TextEditingController _myController = TextEditingController();

  late Stream<List<Map<String, dynamic>>> _myStream;

  @override
  void initState() {
    super.initState();
    _myStream = myController.stream;
    refreshFavorites();
  }

  @override
  void dispose() {
    myController.close();
    super.dispose();
  }

  Future<void> refreshFavorites() async {
    myController.sink.add(await FavoriteDatabase.instance.getAllFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EnkaMobile'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.question_mark),
        ),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: SearchBar(
              controller: _myController,
              shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              )),
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                    onPressed: () async {
                      FavoriteDatabase.instance.addNewFavorite(
                        title: _myController.text,
                        server: getServer(_myController.text[0]),
                        timestamp: DateTime.now().toString(),
                      );
                      await refreshFavorites();
                    },
                    icon: const Icon(Icons.star_border)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CharactersList(
                                    id: _myController.text,
                                  )));
                    },
                    icon: const Icon(Icons.arrow_circle_right_outlined))
              ],
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _myStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CharactersList(
                                          id: snapshot.data![i]['title'],
                                        )));
                          },
                          leading: CircleAvatar(
                            backgroundColor: lightBlue,
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text('UID: ${snapshot.data![i]['title']}'),
                          subtitle:
                              Text('Server: ${snapshot.data![i]['server']}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: lightBlue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
