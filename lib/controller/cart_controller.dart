
import 'package:shopping_demo/utils/imports.dart';

class CartController extends GetxController{

  List<ProductModel> cartData = [];
  RxInt cartLength = 0.obs;


  updateCartData ({required ProductModel productModel}){

      if(cartData.contains(productModel)){
        cartData.remove(productModel);
        cartLength.value = cartData.length;
      }else{
        cartData.add(productModel);
        cartLength.value = cartData.length;
    }

  }

}
