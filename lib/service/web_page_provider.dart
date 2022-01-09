import 'package:get/get.dart';

class WebPageProvider extends GetConnect {
  Future<Response> denemeGetWebPage() =>
      get('http://www.hepsiemlak.com/satilik');

  Future<Response> getWebPage(String baseUrl) => get(baseUrl);
}
