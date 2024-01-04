import 'package:flutter/material.dart';

import '../api/api.dart';
import '../constants/constants.dart';

class Character extends StatelessWidget {
  const Character({
    super.key,
    required this.id,
    required this.index,
    required this.name,
    required this.element,
    required this.image,
    required this.color,
  });

  final String id;
  final int index;
  final String name;
  final String element;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CharacterPage(
        id: id,
        index: index,
        name: name,
        element: element,
        image: image,
        color: color,
      ),
    );
  }
}

class CharacterPage extends StatefulWidget {
  const CharacterPage({
    super.key,
    required this.id,
    required this.index,
    required this.name,
    required this.element,
    required this.image,
    required this.color,
  });

  final String id;
  final int index;
  final String name;
  final String element;
  final String image;
  final Color color;

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchData(widget.id);
    return FutureBuilder<Map<String, dynamic>>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final mainPropId0 = snapshot.data!['avatarInfoList'][widget.index]
                ['equipList'][snapshot
                    .data!['avatarInfoList'][widget.index]['equipList'].length -
                1]['flat']['weaponStats'][0]['appendPropId'];
            final mainPropId1 = snapshot.data!['avatarInfoList'][widget.index]
                ['equipList'][snapshot
                    .data!['avatarInfoList'][widget.index]['equipList'].length -
                1]['flat']['weaponStats'][1]['appendPropId'];
            final propName0 = getPropName(mainPropId0);
            final propName1 = getPropName(mainPropId1);
            return Scaffold(
              backgroundColor: Colors.black,
              body: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover)),
                      )),
                  Positioned(
                      left: 20,
                      top: 70,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu),
                            color: Colors.white,
                          )
                        ],
                      )),
                  Positioned(
                      top: 320,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 45, 45, 45),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.element,
                                style: TextStyle(color: widget.color),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Card(
                                color: Colors.black,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 120,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 90,
                                                    width: 90,
                                                    child: Image.network(
                                                        'https://enka.network/ui/${snapshot.data!['avatarInfoList'][widget.index]['equipList'][snapshot.data!['avatarInfoList'][widget.index]['equipList'].length - 1]['flat']['icon']}.png'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 12),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '$propName0: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][snapshot.data!['avatarInfoList'][widget.index]['equipList'].length - 1]['flat']['weaponStats'][0]['statValue']}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 9),
                                                    ),
                                                    Text(
                                                      '$propName1: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][snapshot.data!['avatarInfoList'][widget.index]['equipList'].length - 1]['flat']['weaponStats'][1]['statValue']}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 9),
                                                    ),
                                                    Text(
                                                      'Weapon Level: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][snapshot.data!['avatarInfoList'][widget.index]['equipList'].length - 1]['weapon']['level']}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 9),
                                                    ),
                                                    Text(
                                                      'Weapon Ascension Level: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][snapshot.data!['avatarInfoList'][widget.index]['equipList'].length - 1]['weapon']['promoteLevel']}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 9),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        )))),
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              itemCount: snapshot
                                      .data!['avatarInfoList'][widget.index]
                                          ['equipList']
                                      .length -
                                  1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                final mainPropId = snapshot
                                            .data!['avatarInfoList']
                                        [widget.index]['equipList'][i]['flat']
                                    ['reliquaryMainstat']['mainPropId'];
                                final propName = getPropName(mainPropId);
                                return Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: SizedBox(
                                          width: 130,
                                          height: 200,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Image.network(
                                                    'https://enka.network/ui/${snapshot.data!['avatarInfoList'][widget.index]['equipList'][i]['flat']['icon']}.png'),
                                              ),
                                              Text(
                                                '$propName: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][i]['flat']['reliquaryMainstat']['statValue']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 120,
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data!['avatarInfoList']
                                                          [widget.index]
                                                          ['equipList'][i]
                                                          ['flat']
                                                          ['reliquarySubstats']!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final subPropId = snapshot
                                                                            .data![
                                                                        'avatarInfoList']
                                                                    [
                                                                    widget
                                                                        .index][
                                                                'equipList'][i]['flat']
                                                            ['reliquarySubstats']
                                                        [index]['appendPropId'];
                                                    final propName =
                                                        getPropName(subPropId);
                                                    return Text(
                                                      '$propName: ${snapshot.data!['avatarInfoList'][widget.index]['equipList'][i]['flat']['reliquarySubstats'][index]['statValue']}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                    ));
                              },
                            ),
                          ),
                        ]),
                      ))
                ]),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
