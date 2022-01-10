import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_scrapper_app/controllers/workflow_controller.dart';

class WorkflowPage extends StatelessWidget {
  const WorkflowPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrapping Flow'),
      ),
      body: Center(
        child: GetX<WorkflowController>(
          init: WorkflowController(),
          builder: (s) => ListView(
            children: s.actions
                .map((e) => ListTile(
                      title: Text(e.title),
                    ))
                .toList(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text("Actions")),
            ListTile(
              title: const Text("Get Children"),
              onTap: () {
                Get.bottomSheet(Container(
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text("Select Parent Element"),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: GetX<WorkflowController>(
                          builder: (controller) => ListView(
                              children: controller.currentAction.output
                                  .map((e) => ListTile(
                                        title: Text(e.toString()),
                                        onTap: () {
                                          controller.getChildren(e);
                                        },
                                      ))
                                  .toList()),
                        ),
                      )
                    ],
                  ),
                ));
              },
            )
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Get.bottomSheet(Container(
                    height: context.mediaQuerySize.height / 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Result",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Card(
                              color: Colors.black38,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetX<WorkflowController>(
                                    builder: (controller) {
                                      return Text(
                                        controller.currentOutput,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/scrappingResult',
                                    arguments: Get.find<WorkflowController>()
                                        .currentAction
                                        .output[0]
                                        .innerHtml);
                              },
                              child: Text("Get Inner Html"))
                        ],
                      ),
                    ),
                  ));
                },
                icon: const Icon(Icons.text_snippet)),
            IconButton(
                onPressed: () {
                  Get.find<WorkflowController>().popLast();
                },
                icon: const Icon(Icons.remove))
          ],
        ),
      ),
    );
  }
}

/*
Actions:
  - get children
  - select element
  - get text
  - get elements by tag name
  - get routes
  - get elements by class name
  - get elements by id
  - get links
  - open link

*/