import 'package:get/get.dart';
import 'package:web_scrapper_app/service/web_page_provider.dart';
import 'package:web_scrapper_app/utils/scrapper.dart';

class ScrapperController extends GetxController {
  void scrapePage() async {
    final provider = WebPageProvider();
    final response = await provider.denemeGetWebPage();

    print(response);

    Scrapper.exampleGetLinks(response);
  }
}
