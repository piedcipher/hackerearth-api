# HackerEarth API

<p align="center"><img width="100" src="https://raw.githubusercontent.com/piedcipher/hackerearth-api/master/img/logo.png?token=ADGVHWJZFKVAWU6SDHHH7G25X3FQG" alt="logo"></p>

Simple and easy-to-use Dart wrapper for [HackerEarth API](https://www.hackerearth.com/docs/wiki/developers/v3/) which provides endpoints for compiling and running code in several languages.

## Usage

A simple usage example:

```dart
// Import this package
import 'package:hackerearth_api/hackerearth_api.dart';

void main() async {
    
    // Create instance and supply client_secret obtained from https://www.hackerearth.com/api/register/
    HackerEarthApiWrapper hackerEarthApiWrapper = HackerEarthApiWrapper(
        clientSecret: 'PUT_CLIENT_SECRET',
    );

    /**
    Call makeRequest method and supply following arguments:
    
        compileAndRun:
            - If it is true then code will be compiled and run.
            - Otherwise code will be compiled. (Default will be false if nothing is supplied)

        programmingLanguage:
            - Language.C
            - Language.CPP
            - Language.CPP11
            - Language.CLOJURE
            - Language.CSHARP
            - Language.GO
            - Language.JAVA
            - Language.JAVASCRIPT
            - Language.JAVASCRIPT_NODE
            - Language.HASKELL
            - Language.OBJECTIVEC
            - Language.PASCAL
            - Language.PERL
            - Language.PHP
            - Language.PYTHON
            - Language.R
            - Language.RUBY
            - Language.RUST
            - Language.SCALA
        
        sourceCode:
            - Add source code in a multiline string
    */
    Map<String, dynamic> response = await hackerEarthApiWrapper.makeRequest(
        compileAndRun: false,
        programmingLanguage: Language.PYTHON,
        sourceCode:
'''from itertools import permutations
print("Hello World!")
print(list(permutations('123')))
print(list(map(lambda x: str(x) + ' is a number', range(5))))''',
    );

    /*
    Sample Responses
    ----------------
    1) Successful compilation:
        {
            async: 0,
            compile_status: OK,
            web_link: https://code.hackerearth.com/d88c2di,
            code_id: d88c2di,
            id: d88c2di
        }
    
    2) Unsuccessful compilation:
        {
            async: 0,
            compile_status: File "/hackerearth/PYTHON_d077_d572_cdb9_ee8c/s_6ae6_4578_a41d_ecc3.py", line 4 print(list(map(lambda x: is a number,
            web_link: https://code.hackerearth.com/0641ffD,
            code_id: 0641ffD,
            id: 0641ffD
        }

    3) Successful execution:
        {
            run_status: {
                memory_used: 64,
                time_limit: 5,
                output_html: Hello&nbsp;World!<br>,
                memory_limit: 262144,
                time_used: 0.108346,
                signal: OTHER,
                status_detail: NA,
                status: AC,
                stderr: ,
                output: Hello World!,
                async: 0,
                request_NOT_OK_reason: ,
                request_OK: True
            },
            compile_status: OK,
            web_link: https://code.hackerearth.com/2abc05e,
            code_id: 2abc05e
        }

    4) Unsuccessful execution:
        {
            run_status: {
                status: CE,
                status_detail: Correct the compilation/syntax errors.
            },
            compile_status: File "/hackerearth/PYTHON_2dda_30d1_0ad8_fef2/s_99dd_2250_d952_b026.py", line 4 print(list(map(lambda x: is a number,
            web_link: https://code.hackerearth.com/6b9837K,
            code_id: 6b9837K
        }
    */
    print(response);
    print(hackerEarthApiWrapper.response); // same as above response variable

    /*
        1) Successful execution response log with emojis:
            💾 Memory Limit: 262144
            💾 Memory Used: 64
            ⏲ Time Limit: 5
            ⏲ Time Used: 0.108573
            ✔️ Status: AC
            🆗 Compile Status: OK
            🔗 Web Link: https://code.hackerearth.com/e288deG
            🧾 Output: 
            ----------
            Hello World!
            [('1', '2', '3'), ('1', '3', '2'), ('2', '1', '3'), ('2', '3', '1'), ('3', '1', '2'), ('3', '2', '1')]
            ['0 is a number', '1 is a number', '2 is a number', '3 is a number', '4 is a number']

        2) Successful execution response log without emojis:
            Memory Limit: 262144
            Memory Used: 64
            Time Limit: 5
            Time Used: 0.108573
            Status: AC
            Compile Status: OK
            Web Link: https://code.hackerearth.com/e288deG
            Output: 
            -------
            Hello World!
            [('1', '2', '3'), ('1', '3', '2'), ('2', '1', '3'), ('2', '3', '1'), ('3', '1', '2'), ('3', '2', '1')]
            ['0 is a number', '1 is a number', '2 is a number', '3 is a number', '4 is a number']
    */
    String prettyLog = hackerEarthApiWrapper.responseLog(withEmoji: true);
    print(prettyLog);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/piedcipher/hackerearth_api
