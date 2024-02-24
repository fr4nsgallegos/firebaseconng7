import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection("products");
  @override
  Widget build(BuildContext context) {
    List<String> documentsIds = [
      "p7uMIYSkXowky8uLOo4s",
      "tZvGasMg6XSAJT5SQdeg"
    ];
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
                productsReference
                    .where("color", isEqualTo: "rojo")
                    .where("price", isLessThan: 20)
                    .get()
                    .then((value) {
                  QuerySnapshot productCollection = value;
                  List<QueryDocumentSnapshot> docs = productCollection.docs;
                  docs.forEach((element) {
                    print(element.data());
                  });
                });
              },
              child: Text("Traer DATA FILTRADA"),
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
            ElevatedButton(
              onPressed: () {
                productsReference.doc("bividis").update({
                  "color": "Negro",
                });
              },
              child: Text("Actualizar"),
            ),
            ElevatedButton(
              onPressed: () {
                productsReference.doc("bividis").delete();
              },
              child: Text("Eliminación"),
            ),
            ElevatedButton(
              onPressed: () async {
                final FirebaseFirestore firestore = FirebaseFirestore.instance;
                await firestore.runTransaction((transaction) async {
                  for (String docId in documentsIds) {
                    final DocumentReference documentReference =
                        firestore.collection("products").doc(docId);
                    await transaction.delete(documentReference);
                  }
                });
              },
              child: Text("Eliminación múltiple"),
            )
          ],
        ),
      ),
    );
  }
}
