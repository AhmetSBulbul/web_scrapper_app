import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrappingResult extends StatelessWidget {
  const ScrappingResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(Get.arguments),
        ),
      ),
    );
  }
}
