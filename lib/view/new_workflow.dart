import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_scrapper_app/controllers/new_workflow_controller.dart';

class NewWorkflowPage extends StatelessWidget {
  NewWorkflowPage({Key? key}) : super(key: key);

  final NewWorkflowController controller = NewWorkflowController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Workflow"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter Base Url',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 4,
              ),
              TextField(
                onChanged: (value) => controller.changeBaseUrl(value),
                decoration: const InputDecoration(
                    prefixText: 'http://', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Shortcuts',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 8,
                child: InkWell(
                  onTap: () {
                    controller.fetchPage(savedVal: 'http://www.hepsiemlak.com');
                    Get.defaultDialog(
                        title: "Fetched Page",
                        content: Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (controller.error.isEmpty &&
                              controller.metaTitle.isNotEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.metaTitle.value,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            '/workflow?baseUrl=${controller.baseUrl.value}',
                                            arguments:
                                                controller.document.value);
                                      },
                                      child: Text("Create Workflow"))
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("Error: ${controller.error.value}"),
                            );
                          }
                        }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network('http://www.hepsiemlak.com/favicon.ico'),
                        const SizedBox(
                          width: 8,
                        ),
                        const Expanded(
                          child: Text("http://www.hepsiemlak.com"),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.fetchPage();
          Get.defaultDialog(
              title: "Fetched Page",
              content: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.error.isEmpty &&
                    controller.metaTitle.isNotEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.metaTitle.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                  '/workflow?baseUrl=${controller.baseUrl.value}',
                                  arguments: controller.document.value);
                            },
                            child: Text("Create Workflow"))
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Error: ${controller.error.value}"),
                  );
                }
              }));
        },
        disabledElevation: 0,
        label: Text("Start Scrapping"),
        icon: Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}
