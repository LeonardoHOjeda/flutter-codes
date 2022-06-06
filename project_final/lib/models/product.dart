// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromMap(jsonString);

import 'dart:convert';

class ProductsResponse {
    ProductsResponse({
        required this.available,
        required this.name,
        required this.price,
        this.rate,
        this.picture,
        this.id
    });

    bool available;
    String name;
    double price;
    int? rate;
    String? picture;
    String? id;

    factory ProductsResponse.fromJson(String str) => ProductsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductsResponse.fromMap(Map<String, dynamic> json) => ProductsResponse(
        available: json["available"],
        name: json["name"],
        price: json["price"].toDouble(),
        rate: json["rate"],
        picture: json["picture"] == null ? null : json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "price": price,
        "rate": rate,
        "picture": picture == null ? null : picture,
    };

    ProductsResponse copy() => ProductsResponse(
      available: available, 
      id: id,
      name: name, 
      picture: picture,
      price: price,
      rate: rate
    );
}
