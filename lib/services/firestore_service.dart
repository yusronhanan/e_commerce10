import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce10/models/product.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
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

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }
}
