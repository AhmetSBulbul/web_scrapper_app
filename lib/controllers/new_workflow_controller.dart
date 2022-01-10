import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:web_scrapper_app/service/web_page_provider.dart';
import 'package:web_scrapper_app/utils/scrapper.dart';

class NewWorkflowController extends GetxController {
  var baseUrl = ''.obs;
  final WebPageProvider _provider = WebPageProvider();
  var metaTitle = ''.obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var document = Document().obs;

  changeBaseUrl(String value) => baseUrl('http://$value');

  void fetchPage({String? savedVal}) async {
    try {
      isLoading(true);
      var response = await _provider.getWebPage(savedVal ?? baseUrl.value);
      document(Scrapper.getDocument(response));
      metaTitle(Scrapper.getMetaTitle(document.value));
    } catch (err) {
      print(err);
      error(err.toString());
    } finally {
      isLoading(false);
    }
  }
}
