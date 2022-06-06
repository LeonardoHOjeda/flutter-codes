import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_final/providers/product_form_provider.dart';
import 'package:project_final/screens/screens.dart';
import 'package:project_final/services/services.dart';
import 'package:project_final/ui/input_decorations.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {

  static String routeName = '/product-details';



  @override
  Widget build(BuildContext context) {

  final productService = Provider.of<ProductsService>(context);

  return ChangeNotifierProvider(
    create: (_) => ProductFormProvider(productService.selectedProduct!),
    child: _ProductScreenBody(productService: productService),
  );

    // return _ProductScreenBody(productService: productService);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;


    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImage(urlImage: productService.selectedProduct?.picture,),
            _ProductForm(),
            SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
        ? CircularProgressIndicator(color: Colors.white)
        : Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, ProductEditScreen.routeName);
        },
      ),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productForm.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(product.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height:10),
              RichText(text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(text: 'Precio: ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  TextSpan(text: '\$${product.price}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                ]
              )),
              Divider(),
              Text('${product.description}', style: TextStyle(fontSize: 15)),
              SizedBox(height:30),
              Text('Tags', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height:10),
              Row(
                children: [
                  (product.available == true)
                  ? _IsAvailableText(backgroundColor: Colors.green, text: 'Disponible', textColor: Colors.white, width: 80)
                  : _IsAvailableText(backgroundColor: Colors.red, text: 'No Disponible', textColor: Colors.white, width: 100),
                  SizedBox(width: 10),
                  (product.secondHand == true)
                  ? _IsAvailableText(backgroundColor: Colors.brown, text: 'Usado', textColor: Colors.white, width: 80)
                  : _IsAvailableText(backgroundColor: Colors.blue, text: 'Nuevo', textColor: Colors.white, width: 80),
                ],
              ),
              SizedBox(height:30),
              Text('Calificacion', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height:10),
              (product.rate != null)
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${product.rate}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 30),),
                  Icon(Icons.star, size: 30, color: Colors.amber,),
                ]
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sin calificacion', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 25),),
                  Icon(Icons.star, size: 25, color: Colors.grey,),
                ]
              ),
              SizedBox(height: 30)
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

class _IsAvailableText extends StatelessWidget {

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double width;

  const _IsAvailableText({
    required this.text, 
    required this.backgroundColor, 
    required this.textColor, 
    required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: textColor)),
      width: width,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}