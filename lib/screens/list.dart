import 'package:enkanetwork/colors/colors.dart';
import 'package:enkanetwork/screens/character.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';

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

class _CharactersListPageState extends State<CharactersListPage> {
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchData(widget.id);
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: snapshot.data!['avatarInfoList']!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Character()),
                            );
                          },
                          title: Text(
                            snapshot.data!['avatarInfoList'][i]['avatarId']
                                .toString(),
                          ),
                        ),
                      );
                    });
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
