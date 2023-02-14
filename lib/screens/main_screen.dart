import 'package:flutter/material.dart';
import 'package:gce_guide/func/get_list.dart';
import 'package:gce_guide/models/card_model.dart';

class MainPage extends StatelessWidget {
  final String url;
  final String title;
  const MainPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: extractData(url),
        builder: (context, snapshot) {
          return Center(
            child: snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CardModel(
                        name: snapshot.data?[index]['name'] ??
                            snapshot.data![index]['error']!.split(":")[0],
                        onTap: () {
                          snapshot.data![index]['name'] != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(
                                      url: snapshot.data![index]['url']!,
                                      title: snapshot.data![index]['name']!,
                                    ),
                                  ),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content:
                                        Text(snapshot.data![index]['error']!),
                                    actions: const [],
                                  ),
                                );
                        },
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
