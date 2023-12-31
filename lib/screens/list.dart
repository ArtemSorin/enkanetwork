import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:enkanetwork/colors/colors.dart';
import 'package:enkanetwork/screens/character.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../constants/constants.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CharactersListPage(id: id),
    );
  }
}

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key, required this.id});

  final String id;

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

Future<Map<String, dynamic>> readJsonFile(String key) async {
  final String response = await rootBundle.loadString(key);
  final data = await json.decode(response);
  return data;
}

class _CharactersListPageState extends State<CharactersListPage> {
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> fetchAllData() async {
      var tableData = await fetchData(widget.id);
      var characterData = await readJsonFile('assets/data/characters.json');
      return {
        'tableData': tableData,
        'characterData': characterData,
      };
    }

    Future<Map<String, dynamic>> futureTable = fetchAllData();
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.person))
          ],
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          title: const Text(
            'My characters',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount:
                      snapshot.data!['tableData']['avatarInfoList']!.length,
                  itemBuilder: (context, i) {
                    int lastUnderscore = snapshot.data!['characterData'][
                            snapshot.data!['tableData']['avatarInfoList'][i]
                                    ['avatarId']
                                .toString()]["SideIconName"]
                        .lastIndexOf('_');
                    String result = snapshot.data!['characterData'][snapshot
                            .data!['tableData']['avatarInfoList'][i]['avatarId']
                            .toString()]["SideIconName"]
                        .substring(lastUnderscore + 1);
                    final mainPropId = snapshot.data!['characterData'][snapshot
                        .data!['tableData']['avatarInfoList'][i]['avatarId']
                        .toString()]["Element"];
                    final current = getColor(mainPropId);
                    return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: current,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Card(
                                color: const Color.fromARGB(255, 45, 45, 45),
                                child: ListTile(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Character(
                                              id: widget.id,
                                              index: i,
                                              color: current,
                                              name: result,
                                              image:
                                                  'https://enka.network/ui/${snapshot.data!['characterData'][snapshot.data!['tableData']['avatarInfoList'][i]['avatarId'].toString()]["SideIconName"]}.png',
                                              element: snapshot
                                                      .data!['characterData'][
                                                  snapshot.data!['tableData']
                                                          ['avatarInfoList'][i]
                                                          ['avatarId']
                                                      .toString()]["Element"],
                                            )),
                                  ),
                                  leading: CircleAvatar(
                                      backgroundColor: current,
                                      child: Center(
                                        child: Image.network(
                                            'https://enka.network/ui/${snapshot.data!['characterData'][snapshot.data!['tableData']['avatarInfoList'][i]['avatarId'].toString()]["SideIconName"]}.png'),
                                      )),
                                  title: Text(
                                    result,
                                    style: TextStyle(
                                        color: current,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  subtitle: Text(
                                    'Level ${snapshot.data!['tableData']['playerInfo']['showAvatarInfoList'][i]['level']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  trailing: Text(
                                    snapshot.data!['characterData'][snapshot
                                        .data!['tableData']['avatarInfoList'][i]
                                            ['avatarId']
                                        .toString()]["Element"],
                                    style: TextStyle(
                                        color: current,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ))));
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(
                child: CircularProgressIndicator(
                  color: black,
                ),
              );
            }));
  }
}
