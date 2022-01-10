import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:web_scrapper_app/models/action_model.dart';
import 'package:web_scrapper_app/models/scrapped_element_model.dart';
import 'package:web_scrapper_app/service/web_page_provider.dart';
import 'package:web_scrapper_app/utils/scrapper.dart';

class WorkflowController extends GetxController {
  var metaTitle = ''.obs;
  var document = Document().obs;
  var baseUrl = ''.obs;
  var actions = <ActionModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  final WebPageProvider _provider = WebPageProvider();

  ActionModel get currentAction => actions.last;
  List<ActionModel> get actionsList => actions;
  String get currentOutput => actions.last.output.isNotEmpty
      ? actions.last.output
          .map((e) =>
              ScrappedElement(e.toString(), e.attributes.toString()).toString())
          .toString()
      : '';

  @override
  void onInit() {
    baseUrl(Get.parameters['baseUrl']);
    print(baseUrl.value);
    document(Get.arguments);
    metaTitle(Scrapper.getMetaTitle(document.value));
    actions.add(ActionModel(
        title: metaTitle.value,
        input: document.value.documentElement,
        output: Scrapper.getChildren(document.value.documentElement) ?? []));
    print(metaTitle.value);
    print(document.value.body?.text);
    print(baseUrl.value);
    super.onInit();
  }

  getChildren(Element element) => actions.add(ActionModel(
      title: 'Get Children',
      input: element,
      output: Scrapper.getChildren(element) ?? []));

  getLinks(Element element) => actions.add(ActionModel(
      title: 'Get Links',
      input: element,
      output: Scrapper.getLinks(element) ?? []));

  clickLink(Element element) async {
    try {
      isLoading(true);
      var response = await _provider.getWebPage(
          '${baseUrl.value}${element.attributes['href'].toString()}');
      actions.add(ActionModel(
          output: Scrapper.getChildren(
                  Scrapper.getDocument(response).documentElement) ??
              [],
          title: "Click Link",
          input: element));
      error('');
    } catch (err) {
      error(err.toString());
    } finally {
      isLoading(false);
    }
  }

  popLast() {
    if (actions.length > 1) {
      actions.removeLast();
      error('');
    }
  }
}
