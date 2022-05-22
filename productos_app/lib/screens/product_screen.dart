import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';



class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productoService: productService),
      );

    // return 
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productoService,
  }) : super(key: key);

  final ProductsService productoService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productoService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,),
                    onPressed: () => Navigator.of(context).pop(),)
                    
                  ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,),
                    onPressed: () => {
                      //TODO: Camara o galeria
                    })
                  )
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //TODO: Save
        },
        child: Icon(Icons.save_alt_outlined),),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

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
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del Producto', labelText: 'Nombre:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  if(double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                }, 
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecorations.authInputDecoration(hintText: '\$150', labelText: 'Precio:'),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.available,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailabilty(value)),
              SizedBox(height: 30)
            ],
            )
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}