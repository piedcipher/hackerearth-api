import 'package:hackerearth_api/hackerearth_api.dart';

void main() async {
  HackerEarthApiWrapper hackerEarthApiWrapper = HackerEarthApiWrapper(
    clientSecret: 'PUT_CLIENT_SECRET',
  );
  Map<String, dynamic> response = await hackerEarthApiWrapper.makeRequest(
    compileAndRun: false,
    programmingLanguage: Language.PYTHON,
    sourceCode: '''
from itertools import permutations
print("Hello World!")
print(list(permutations('123')))
print(list(map(lambda x: str(x) + ' is a number', range(5))))
''',
  );
  print(response);
  print(hackerEarthApiWrapper.response); // same as above response
  print(hackerEarthApiWrapper.responseLog(withEmoji: true));
}
