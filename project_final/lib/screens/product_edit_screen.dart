import 'package:flutter/material.dart';
import 'package:project_final/services/services.dart';
import 'package:project_final/ui/input_decorations.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {

  static String routeName = '/product-card';



  @override
  Widget build(BuildContext context) {

  final productService = Provider.of<ProductsService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(urlImage: productService.selectedProduct?.picture,),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, size: 40, color: Colors.white,),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, size: 40, color: Colors.white,),
                    onPressed: () => (){},
                  )
                )
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){},
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del producto', labelText: 'Nombre del producto' )
              ),
              SizedBox(height:30),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(hintText: '\$50', labelText: 'Precio')
              ),
              SizedBox(height:30),
              SwitchListTile(
                title: Text('Esta disponible'),
                activeColor: Colors.green,
                value: true, 
                onChanged: (value){}
                )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(25),
      bottomLeft: Radius.circular(25),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}