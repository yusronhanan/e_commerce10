import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_input_field_fb1.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [
              CustomInputFieldFb1(
                inputController: titleTextEditingController,
                labelText: 'Product Name',
                hintText: 'Product Name',
              ),
              const SizedBox(height: 15),
              CustomInputFieldFb1(
                inputController: descriptionEditingController,
                labelText: 'Product Description',
                hintText: 'Product Description',
              ),
              const SizedBox(height: 15),
              CustomInputFieldFb1(
                inputController: priceEditingController,
                labelText: 'Price',
                hintText: 'Price',
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () => _addProduct(),
                  child: const Text("Add Product")),
            ])));
  }

  _addProduct() {}
}
