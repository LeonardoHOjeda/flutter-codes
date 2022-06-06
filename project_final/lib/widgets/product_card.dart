import 'package:flutter/material.dart';
import 'package:project_final/models/models.dart';


class ProductCard extends StatelessWidget {

  final ProductsResponse product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
          children: [
            _imageCard(urlImage: product.picture),
            _productDetails(product: product,)
          ],
        ),
        width: double.infinity,
        height: 100,
        decoration: _cardBorders(),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _productDetails extends StatelessWidget {

  final ProductsResponse product;

  const _productDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, left: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name, 
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), 
              overflow: TextOverflow.ellipsis, 
              maxLines: 1,
              // softWrap: false,
            ),
            Text('\$${product.price}', style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic, fontSize: 18),),
            (product.available == true)
            ? _IsAvailableText(backgroundColor: Colors.green, text: 'Disponible', textColor: Colors.white, width: 80)
            : _IsAvailableText(backgroundColor: Colors.red, text: 'No Disponible', textColor: Colors.white, width: 100),
            Row(
              children: [
                Text('${product.rate}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),),
                Icon(Icons.star, size: 15, color: Colors.amber,),
              ]
            ),
          ],
        ),
      )
    );
  }
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

class _imageCard extends StatelessWidget {

  final String? urlImage;

  const _imageCard({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10)
      ),
      child: Container(
        width: 100,
        height: 100,
        child: (urlImage != null)
          ? FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'), 
            image: NetworkImage(urlImage!),
            fit: BoxFit.cover,
          )
          : Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,)
      ),
    );
  }
}