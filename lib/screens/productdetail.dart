import 'package:flutter/material.dart';
import 'package:student_project/db/dbHelper.dart';
import 'package:student_project/models/product.dart';
import 'package:student_project/screens/productupdate.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() => ProductDetailState(product);
}

DbHelper dbHelper = new DbHelper();
enum Choise { Delete, Update }

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail for ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Choise>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choise>>[
              PopupMenuItem<Choise>(
                child: Text("Delete ${product.name}"),
                value: Choise.Delete,
              ),
              PopupMenuItem<Choise>(
                child: Text("Update ${product.name}"),
                value: Choise.Update,
              )
            ],
          )
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                tileColor: Colors.deepOrangeAccent,
                leading: Icon(Icons.shop),
                title: Text(product.name),
                subtitle: Text(product.description),
              ),
              Text("${product.name} price is :${product.price}"),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("add to card"),
                      onPressed: () {
                        AlertDialog alertDialog = new AlertDialog(
                          title: Text("Success"),
                          content: Text("${product.name} added to cart!"),
                        );
                        showDialog(
                            context: context, builder: (_) => alertDialog);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void select(Choise choice) async {
    int result;
    switch (choice) {
      case Choise.Delete:
        Navigator.pop(context, true);
        result = await dbHelper.delete(product.id);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Deleted product : ${product.name} "),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case Choise.Update:
        gotoProductUpdate(product);
        break;
    }
  }

  void gotoProductUpdate(Product products) async {
    int count;
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductUpdate(products)));
    if (result != null) {
      if (result) {
        setState(() {
          var productsFuture = dbHelper.getsProductsWithId(products.id);
          productsFuture.then((data) {
            Product prod;
            count = data.length;
            for (var i = 0; i < count; i++) {
              prod = Product.fromObject(data[0]);
            }
            setState(() {
              product = prod;
            });
          });
        });
      }
    }
  }
}
