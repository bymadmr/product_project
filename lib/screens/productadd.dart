import 'package:flutter/material.dart';
import 'package:student_project/db/dbHelper.dart';
import 'package:student_project/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  DbHelper dbHelper = new DbHelper();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: txtname,
                decoration: InputDecoration(
                  labelText: "Name",
                )),
            TextField(
                controller: txtdescription,
                decoration: InputDecoration(
                  labelText: "Description",
                )),
            TextField(
                controller: txtprice,
                decoration: InputDecoration(
                  labelText: "Price",
                )),
            FlatButton(
              onPressed: () {
                save();
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  void save() async {
    int result = await dbHelper.insert(Product(
        txtname.text, txtdescription.text, double.tryParse(txtprice.text)));
    if (result != 0) {
      Navigator.pop(context, true);
      AlertDialog alertDialog = new AlertDialog(
        title: Text("Success"),
        content: Text("Added product : ${txtname.text} "),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
