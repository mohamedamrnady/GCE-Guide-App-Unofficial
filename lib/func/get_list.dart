import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

Future<List<Map<String, String?>>> extractData(String url) async {
  final List<Map<String, String?>> finalLi = [];
  final response = await http.Client().get(Uri.parse(url), headers: {
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
  });
  if (response.statusCode == 200) {
    var document = parser.parse(response.body);
    try {
      var responseString = document
          .getElementsByClassName('paperslist')[0]
          .getElementsByTagName('a');
      for (var i = 0; i < responseString.length; i++) {
        finalLi.add(
          Map.fromEntries(
            [
              MapEntry('name', responseString[i].text),
              MapEntry('url',
                  "$url${responseString[i].attributes['href']!.replaceAll(' ', '%20').replaceAll("/", "")}/"),
            ],
          ),
        );
      }
      return finalLi;
    } catch (e) {
      return [
        {'error': e.toString()}
      ];
    }
  } else {
    return [
      {'error': response.statusCode.toString()}
    ];
  }
}
