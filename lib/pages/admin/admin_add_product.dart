import 'dart:io';

import 'package:e_commerce10/app/providers.dart';
import 'package:e_commerce10/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
            child: SingleChildScrollView(
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
                const SizedBox(height: 15),
                Consumer(
                  builder: (context, watch, child) {
                    final image = ref.watch(addImageProvider);
                    return image == null
                        ? const Text('No image selected')
                        : Image.file(
                            File(image.path),
                            height: 200,
                          );
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: const Text('Upload Image'),
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      ref.watch(addImageProvider.state).state = image;
                    }
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () => _addProduct(),
                    child: const Text("Add Product")),
                const SizedBox(height: 15),
              ]),
            )));
  }

  _addProduct() async {
    final storage = ref.read(databaseProvider);
    final fileStorage = ref.read(storageProvider); // reference file storage
    final imageFile =
        ref.read(addImageProvider.state).state; // referece the image File

    if (storage == null || fileStorage == null || imageFile == null) {
      // make sure none of them are null
      // ignore: avoid_print
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }

    // Upload to Filestorage
    final imageUrl = await fileStorage.uploadFile(
      // upload File using our
      imageFile.path,
    );

    await storage.addProduct(Product(
      name: titleTextEditingController.text,
      description: descriptionEditingController.text,
      price: double.parse(priceEditingController.text),
      imageUrl: imageUrl,
    ));
    Navigator.pop(context);
  }
}
