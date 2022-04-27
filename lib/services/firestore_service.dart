import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce10/models/product.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    await firestore
        .collection("products")
        .add(product.toMap())
        .then((value) => print(value))
        .catchError((onError) => print("Error"));
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // loop through docs
              final d = doc.data(); // for each doc get the data
              return Product.fromMap(d); // convert into a map
            }).toList()); // build a list out of the products mapping
  }
}
