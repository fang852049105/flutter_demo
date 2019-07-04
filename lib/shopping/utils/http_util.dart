import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";
  static HttpUtil instance;
  Dio dio;

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    dio = Dio(BaseOptions(
      headers: {'platform': 'android'},
      connectTimeout: 5000,
      receiveTimeout: 100000,
      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    ));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 10.1.133.227:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    };
  }

  //get请求
  get(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requstHttp(url, successCallBack, GET, params, errorCallBack);
  }

  //post请求
  post(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requstHttp(url, successCallBack, POST, params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, params, Function errorCallBack]) async {
    String errorMsg = '';
    int code;
    try {
      Response response;
      _addStartHttpInterceptor(dio); //添加请求之前的拦截器
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }

      code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg);
        return;
      }
//
//      String dataStr = response.data.toString();
//      Map<String, dynamic> dataMap = json.decode(dataStr);
//      if (dataMap != null && dataMap[CODE] != null) {
//        errorMsg = '错误码：' + dataMap[CODE].toString() + '，' + response.data.toString();
//        _error(errorCallBack, errorMsg);
//        return;
//      }

      if (successCallBack != null) {
        successCallBack(response.data);
      }
    } catch (exception) {
      _error(errorCallBack, exception.toString());
    }
  }

  _error(Function errorCallBack, String error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  _addStartHttpInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        Map<String, dynamic> headers = options.headers;
        Map<String, dynamic> body = options.data;
        /*request['token'] = '1111111111';
      headers['addParam'] = 'aaaaaaaaaaaaaaa';*/
        return options;
      },
      onResponse: (Response response) {
        return response;
      },
      onError: (DioError e) {
        return e;
      }
    ));
  }
}
