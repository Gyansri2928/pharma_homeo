//import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_homeo/controller/home_controller.dart';
import 'package:pharma_homeo/widget/dropdown.dart';


class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add new Product",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.indigoAccent.shade700,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productnmcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Name"),
                      hintText: "Enter the product name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productdesccontroller,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Description"),
                      hintText: "Enter your product's description"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productImgcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: Text("Image URL"),
                      hintText: "Paste the image url"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productpricecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Price"),
                      hintText: "Enter the Product Price"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(child: DropDown(
                      items: ["Loafers", "Boots", "Clogs","Sports"],
                      hnttxt: ctrl.Category,
                      onSelected: (selectedValue) {
                          ctrl.Category = selectedValue??'general';
                          ctrl.update();
                      },)),
                    Flexible(child: DropDown(
                      items: ['Adidas', 'Reebok', 'Bata', 'Puma'],
                      hnttxt: ctrl.brand,
                      onSelected: (selectedValue) {
                      ctrl.brand = selectedValue??'unbranded';
                      ctrl.update();
                    },))
                  ],
                ),
                const Text("Offer Product ?"),
                DropDown(items: ['true', 'false'],
                  hnttxt: ctrl.offer.toString(),
                  onSelected: (selectedValue) {
                    ctrl.offer = bool.tryParse(selectedValue ?? 'false')??false;
                    ctrl.update();
                  },),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: const Text("Add Product")
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
