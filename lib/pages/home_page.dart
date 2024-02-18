import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection("products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                productsReference.get().then((value) {
                  QuerySnapshot productCollection = value;
                  List<QueryDocumentSnapshot> docs = productCollection.docs;
                  docs.forEach((element) {
                    print(element.id);
                  });
                });
              },
              child: Text("Traer DATA"),
            ),
            ElevatedButton(
              onPressed: () {
                productsReference.add({
                  'nombre': 'Juan',
                  'apellido': 'Portal',
                });
              },
              child: Text("Insertar 1"),
            ),
            ElevatedButton(
              onPressed: () {
                productsReference.doc('bividis').set(
                  {"tipo": "ropa", "color": "Blanco"},
                );
              },
              child: Text("Insertar 2"),
            ),
          ],
        ),
      ),
    );
  }
}
