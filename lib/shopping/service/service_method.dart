import 'package:dio/dio.dart';
import 'package:flutter_demo/shopping/config/service_url.dart';
import 'dart:async';
import 'dart:io';


Future getContent(url, {formData}) async {
  try {
    print("======开始获取数据======url== {$url}");
    Response response;
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 10.1.133.227:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    };
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('======接口出现异常======');
    }

  } catch(e) {
    return print('error: =======>${e}');
  }
}
