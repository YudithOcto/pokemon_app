import 'dart:io';

String responseModelReader(String name) =>
    File('test/fake_response_model/$name').readAsStringSync();
