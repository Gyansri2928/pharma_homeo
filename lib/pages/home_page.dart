import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:pharma_homeo/controller/home_controller.dart';
import 'package:pharma_homeo/pages/add_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Footware Store"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ctrl.products[index].name ?? ''),
              subtitle: Text((ctrl.products[index].price ?? 0).toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  ctrl.delete(ctrl.products[index].id??"");
                },
              ),
            );
          },
          itemCount: ctrl.products.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddProduct());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
