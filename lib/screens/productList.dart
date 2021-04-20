import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_project/db/dbHelper.dart';
import 'package:student_project/models/product.dart';
import 'package:student_project/screens/productadd.dart';
import 'package:student_project/screens/productdetail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductListState();
}

class ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product> products;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = [];
      getData();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoProductAdd();
        },
        tooltip: "Add new Product",
        child: Icon(Icons.add),
      ),
      body: productListItems(),
    );
  }

  ListView productListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.greenAccent,
          elevation: 2, //büyüklük
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellowAccent,
              child: Text("A"),
            ), //başında circle oluşturur.
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].description),
            onTap: () {
              gotoDetail(this.products[position]);
            },
          ),
        );
      },
    );
  }

  void getData() {
    var dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      var productsFuture = dbHelper.getsProducts();
      productsFuture.then((data) {
        List<Product> productsdata = [];
        count = data.length;
        for (var i = 0; i < count; i++) {
          productsdata.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsdata;
          count = count;
        });
      });
    });
  }

  void gotoDetail(Product product) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(
                product))); //Navigator bir sayfadan diğerine gitmek için push geri gelmek için pop
    if (result != null) {
      if (result) {
        getData();
      }
    }
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getData();
      }
    }
  }
}
