import 'package:flutter/material.dart';
import 'package:gce_guide/func/get_list.dart';
import 'package:gce_guide/ui/buttons/card_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    padding: const EdgeInsets.all(12.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CardModel(
                        name: snapshot.data?[index]['name'] ??
                            snapshot.data![index]['error']!.split(":")[0],
                        onTap: () async {
                          snapshot.data![index]['name'] != null
                              ? !snapshot.data![index]['name']!.endsWith('.pdf')
                                  ? !snapshot.data![index]['name']!
                                          .endsWith('.docx')
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(
                                              url: snapshot.data![index]
                                                  ['url']!,
                                              title: snapshot.data![index]
                                                  ['name']!,
                                            ),
                                          ),
                                        )
                                      : await launchUrl(
                                          Uri.parse(
                                            snapshot.data![index]['url']!
                                                .substring(
                                                    0,
                                                    snapshot
                                                            .data![index]
                                                                ['url']!
                                                            .length -
                                                        1),
                                          ),
                                          mode: LaunchMode.externalApplication,
                                        )
                                  : await launchUrl(
                                      Uri.parse(
                                        snapshot.data![index]['url']!.substring(
                                            0,
                                            snapshot.data![index]['url']!
                                                    .length -
                                                1),
                                      ),
                                      mode: LaunchMode.externalApplication,
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
