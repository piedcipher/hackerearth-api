import 'dart:convert' show jsonDecode;

import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;
import 'package:demoji/demoji.dart';

abstract class Language {
  static const String C = 'C';
  static const String CPP = 'CPP';
  static const String CPP11 = 'CPP11';
  static const String CLOJURE = 'CLOJURE';
  static const String CSHARP = 'CSHARP';
  static const String GO = 'GO';
  static const String JAVA = 'JAVA';
  static const String JAVASCRIPT = 'JAVASCRIPT';
  static const String JAVASCRIPT_NODE = 'JAVASCRIPT_NODE';
  static const String HASKELL = 'HASKELL';
  static const String OBJECTIVEC = 'OBJECTIVEC';
  static const String PASCAL = 'PASCAL';
  static const String PERL = 'PERL';
  static const String PHP = 'PHP';
  static const String PYTHON = 'PYTHON';
  static const String R = 'R';
  static const String RUBY = 'RUBY';
  static const String RUST = 'RUST';
  static const String SCALA = 'SCALA';
}

class HackerEarthApiWrapper {
  String _clientSecret;
  static const String _kBaseApi = 'https://api.hackerearth.com/v3/code';
  Map<String, dynamic> _response = {};

  HackerEarthApiWrapper({@required String clientSecret}) {
    this._clientSecret = clientSecret;
  }

  Future<Map<String, dynamic>> makeRequest({
    final bool compileAndRun = false,
    @required final String programmingLanguage,
    @required final String sourceCode,
  }) async {
    final http.Response response = await http.post(
      compileAndRun ? '$_kBaseApi/run/' : '$_kBaseApi/compile/',
      body: {
        'client_secret': _clientSecret,
        'source': sourceCode,
        'lang': programmingLanguage,
      },
    );
    _response = jsonDecode(response.body);
    return _response;
  }

  Map<String, dynamic> get response => _response;

  String responseLog({bool withEmoji = false}) {
    if (withEmoji) {
      if (_response.containsKey('run_status')) {
        if (_response['run_status']['status'] == 'AC') {
          return '${Demoji.floppy_disk} Memory Limit: ${_response['run_status']['memory_limit']}\n'
              '${Demoji.floppy_disk} Memory Used: ${_response['run_status']['memory_used']}\n'
              '${Demoji.timer_clock}  Time Limit: ${_response['run_status']['time_limit']}\n'
              '${Demoji.timer_clock}  Time Used: ${_response['run_status']['time_used']}\n'
              '${Demoji.heavy_check_mark}  Status: ${_response['run_status']['status']}\n'
              '${Demoji.ok} Compile Status: ${_response['compile_status']}\n'
              '${Demoji.link} Web Link: ${_response['web_link']}\n'
              '${Demoji.receipt}  Output: \n----------\n${_response['run_status']['output']}';
        } else if (_response['run_status']['status'] == 'CE') {
          return '${Demoji.sob} Status Details: ${_response['run_status']['status_detail']}\n'
              '${Demoji.x} Status: ${_response['run_status']['status']}\n'
              '${Demoji.link} Web Link: ${_response['web_link']}\n'
              '${Demoji.receipt}  Compile Status: \n------------------\n${_response['compile_status']}';
        }
      } else {
        return '${Demoji.link} Web Link: ${_response['web_link']}\n'
            '${Demoji.receipt}  Compile Status: \n------------------\n${_response['compile_status']}';
      }
    } else {
      if (_response.containsKey('run_status')) {
        if (_response['run_status']['status'] == 'AC') {
          return 'Memory Limit: ${_response['run_status']['memory_limit']}\n'
              'Memory Used: ${_response['run_status']['memory_used']}\n'
              'Time Limit: ${_response['run_status']['time_limit']}\n'
              'Time Used: ${_response['run_status']['time_used']}\n'
              'Status: ${_response['run_status']['status']}\n'
              'Compile Status: ${_response['compile_status']}\n'
              'Web Link: ${_response['web_link']}\n'
              'Output: \n-------\n${_response['run_status']['output']}';
        } else if (_response['run_status']['status'] == 'CE') {
          return 'Status Details: ${_response['run_status']['status_detail']}\n'
              'Status: ${_response['run_status']['status']}\n'
              'Web Link: ${_response['web_link']}\n'
              'Compile Status: \n---------------\n${_response['compile_status']}';
        }
      } else {
        return 'Web Link: ${_response['web_link']}\n'
            'Compile Status: \n---------------\n${_response['compile_status']}';
      }
    }
    return '';
  }
}
