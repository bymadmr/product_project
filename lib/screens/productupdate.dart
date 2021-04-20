import 'package:flutter/material.dart';
import 'package:student_project/db/dbHelper.dart';
import 'package:student_project/models/product.dart';

class ProductUpdate extends StatefulWidget {
  Product product;
  ProductUpdate(this.product);
  @override
  State<StatefulWidget> createState() => ProductUpdateState(product);
}

class ProductUpdateState extends State {
  Product product;
  ProductUpdateState(this.product);
  DbHelper dbHelper = new DbHelper();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  TextEditingController txtprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtname.text = product.name;
    txtdescription.text = product.description;
    txtprice.text = product.price.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
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
    int result = await dbHelper.update(Product.witId(product.id, txtname.text,
        txtdescription.text, double.tryParse(txtprice.text)));
    if (result != 0) {
      Navigator.pop(context, true);
      AlertDialog alertDialog = new AlertDialog(
        title: Text("Success"),
        content: Text("Update product : ${txtname.text} "),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
