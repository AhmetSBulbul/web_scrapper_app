import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:web_scrapper_app/models/action_model.dart';
import 'package:web_scrapper_app/utils/scrapper.dart';

class WorkflowController extends GetxController {
  var metaTitle = ''.obs;
  var document = Document().obs;
  var baseUrl = ''.obs;
  var actions = <ActionModel>[].obs;

  ActionModel get currentAction => actions.last;
  List<ActionModel> get actionsList => actions;
  String get currentOutput => actions.last.output.isNotEmpty
      ? actions.last.output
          .map((e) => 'tag: $e \n attributes: ${e.attributes}\n\n')
          .toList()
          .toString()
      : '';

  @override
  void onInit() {
    baseUrl(Get.parameters['baseUrl']);
    document(Get.arguments);
    metaTitle(Scrapper.getMetaTitle(document.value));
    actions.add(ActionModel(
        title: metaTitle.value,
        input: document.value.documentElement,
        output: Scrapper.getChildren(document.value.documentElement) ?? []));
    print(metaTitle.value);
    print(document.value.body?.text);
    print(baseUrl);
    super.onInit();
  }

  getChildren(Element element) => actions.add(ActionModel(
      title: 'Get Children',
      input: element,
      output: Scrapper.getChildren(element) ?? []));

  popLast() {
    if (actions.length > 1) {
      actions.removeLast();
    }
  }
}
