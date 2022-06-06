import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_final/services/services.dart';
import 'package:provider/provider.dart';

class ProductImage extends StatelessWidget {

  final String? urlImage;

  const ProductImage({super.key, this.urlImage});

  @override
  Widget build(BuildContext context) {
  final productService = Provider.of<ProductsService>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: getImage(urlImage)
        
        
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0,5)
      )
    ]
  );

  Widget getImage(String? picture){
    if(picture == null)
    return Image(
      image: AssetImage('assets/no-image.png'), 
      fit: BoxFit.cover);
    if(picture.startsWith('http')){
      return Opacity(
          opacity: 0.90,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(urlImage!),
              fit: BoxFit.cover,
            ),
          ),
        );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}