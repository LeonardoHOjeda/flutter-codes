import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_final/providers/product_form_provider.dart';
import 'package:project_final/services/services.dart';
import 'package:project_final/ui/input_decorations.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductEditScreen extends StatelessWidget {

  static String routeName = '/product-card';



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
                    onPressed: () async{
                      print('Click');
                      //TODO: Abrir camara
                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera, 
                        imageQuality: 100
                      );

                      if(pickedFile == null){
                        print('No selecciono nada');
                        return;
                      }

                      print('Tenemos imagen ${pickedFile.path}');
                      productService.updateSelectedProductImage(pickedFile.path);
                    },
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
        child: productService.isSaving
        ? CircularProgressIndicator(color: Colors.white)
        : Icon(Icons.save),
        onPressed: productService.isSaving
          ? null
          : () async{
          if(!productForm.isValidForm()) return;

          final String? imageUrl = await productService.uploadImage();
          if(imageUrl != null) productForm.product.picture = imageUrl;
          await productService.saveOrCreateProduct(productForm.product);
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
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.length < 1)
                    return 'Ingresa un valor correcto';
                },
                decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del producto', labelText: 'Nombre del producto' )
              ),
              SizedBox(height:30),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) == null){
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(hintText: '\$50', labelText: 'Precio')
              ),
              SizedBox(height:30),
              SwitchListTile(
                title: Text('Esta disponible'),
                activeColor: Colors.green,
                value: product.available, 
                onChanged: (value){
                  productForm.updateAvailability(value);
                }
              ),
              SwitchListTile(
                title: Text('Es usado'),
                activeColor: Colors.green,
                value: product.secondHand, 
                onChanged: (value){
                  productForm.updateSecondHand(value);
                }
              ),
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