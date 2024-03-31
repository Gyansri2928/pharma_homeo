import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_homeo/model/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productnmcontroller = TextEditingController();
  TextEditingController productdesccontroller = TextEditingController();
  TextEditingController productImgcontroller = TextEditingController();
  TextEditingController productpricecontroller = TextEditingController();

  String Category = 'general';
  String brand = 'un-branded';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    productCollection = firestore.collection('products');
    await fetchproducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
          id: doc.id,
          name: productnmcontroller.text,
          category: Category,
          description: productdesccontroller.text,
          price: double.tryParse(productpricecontroller.text),
          brand: brand,
          image: productImgcontroller.text,
          offer: offer);
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added successfully',
          colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
      print(e);
    }
  }

  fetchproducts() async {
    try {
      QuerySnapshot productsnapshot = await productCollection.get();
      final List<Product> retrieveproduct = productsnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrieveproduct);
      Get.snackbar('Success', "Product fetched successfully",
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
    }finally{
      update();
    }
  }

  delete(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchproducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
    }
  }

  setValuesDefault() {
    productnmcontroller.clear();
    productdesccontroller.clear();
    productpricecontroller.clear();
    productImgcontroller.clear();
    Category = 'general';
    brand = 'un-branded';
    offer = false;
    update();
  }
}
