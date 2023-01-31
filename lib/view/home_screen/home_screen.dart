

import 'package:shopping_demo/controller/cart_controller.dart';
import 'package:shopping_demo/utils/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ProductListController productListController = Get.put(ProductListController());
  AuthenticationRepository authenticationRepository = Get.put(AuthenticationRepository());
  CartController cartController = Get.put(CartController());
  bool isSearching = false;
  List<ProductModel> searchedList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    init();
    super.initState();
  }

  init(){
    productListController.getPhotoData(context: context, pageCount: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.themeColor,
          appBar: AppBar(
            title: Text(str_cart),
            actions: [
              TextButton(
                  onPressed: (){
                    validateAndLogOut();
                  },
                  child: Text('LogOut',style: AppTextStyles.appTextStyle(color: Colors.white,fontSize: 15),)
              ),
              Stack(
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.shopping_cart, color: Colors.white,)),
                  Positioned(
                      left: 20,
                      right: 20,
                      child: Obx(() => Text(cartController.cartLength.value.toString(),style: AppTextStyles.appTextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),

                ],
              ),
            ],
          ),
          body: GetBuilder<ProductListController>(
            init: productListController,
            builder: (controller){
              return controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                        child: TextField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search Product',
                            hintText: 'Search Your Product',
                          ),
                          onChanged: (value){
                            print("--------Onchnage called-");
                            validateAndShowSearchResult(val : value);
                          },
                        ),
                      ),
                      Expanded(
                          child: isSearching?showSearchedData():buildGridView(controller: controller)
                      ),
                    ],
                  );
            },
          ),
        )
    );
  }

  Widget buildGridView({required ProductListController controller}) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: controller.productListModel?.length,
        itemBuilder: (context, index) {
          scrollController.addListener(() {

            if(scrollController.position.maxScrollExtent == scrollController.position.pixels){
              productListController.pageCount.value = productListController.pageCount.value+1;
              print("page Count => ${productListController.pageCount.value }");
            }else{

            }

          });
          return buildImageWidget(controller: controller,index: index);
        });
  }

  Widget showSearchedData() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: searchedList.length,
        itemBuilder: (BuildContext ctx, index) {
          return showImage(url: searchedList[index].url ?? '');
        });
  }

  Widget buildImageWidget({required ProductListController controller, required int index}) {
    return GestureDetector(
      onTap: (){
        setState(() {
          validateAndAddToCart(controller: controller, index: index);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        color: cartController.cartData.contains(controller.productListModel![index])?Colors.red:Colors.transparent,
        child: showImage(url: controller.productListModel?[index].url ?? ''),
      ),
    );
  }

  Widget showImage({required String url}){
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,size: 50,),
    );
  }

  void validateAndAddToCart({required ProductListController controller, required int index}) {
    print("----------ID => ${controller.productListModel?[index].id}");
    cartController.updateCartData(productModel: controller.productListModel![index]);
  }

  void validateAndShowSearchResult({required String val}) {

    print("---------Ti   ::    Value => ${val}--------------");
    productListController.productListModel?.forEach((element) {
      isSearching = true;
      if(element.title!.contains(val)){
        print("---------Title => ${element.title}    ::    Value => ${val}--------------");
        searchedList.add(element);
      }
      setState(() {});
    });

  }

  void validateAndLogOut() {
    authenticationRepository.logout();
  }


}


