import 'package:flutter/material.dart';
import 'package:project_final/models/product.dart';
import 'package:project_final/screens/product_edit_screen.dart';
import 'package:project_final/screens/screens.dart';
import 'package:project_final/services/services.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    if(productsService.isLoading) return LoadingScreen();

    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido ${user.email}', style: TextStyle(fontSize: 14)),
          actions: [
            IconButton(onPressed: () => context.read<FirebaseAuthMethods>().signOut(context), icon: Icon(Icons.logout))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async =>  {
            await ProductsService()
          },
          child: ListView.builder(
            itemCount: productsService.products.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                productsService.selectedProduct = productsService.products[index].copy();
                Navigator.pushNamed(context, ProductScreen.routeName);
              },
              child: ProductCard(product: productsService.products[index],))
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            productsService.selectedProduct = new ProductsResponse(available: true, secondHand: false, name: '', price: 0);
            Navigator.pushNamed(context, ProductEditScreen.routeName);
          },
        )
      );
  }
}


// Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (!user.isAnonymous && user.phoneNumber == null)
//               Text(user.email!),
//             if (!user.isAnonymous && user.phoneNumber == null)
//               Text(user.providerData[0].providerId),
//             if (user.phoneNumber != null) Text(user.phoneNumber!),
//             Text(user.uid),
//             CustomButton(
//                 onTap: () {
//                   context.read<FirebaseAuthMethods>().signOut(context);
//                 },
//                 text: 'Cerrar Sesion')
//           ],
//         )