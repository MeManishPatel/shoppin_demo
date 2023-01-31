
import '../utils/imports.dart';

class ProductListController extends GetxController{
  ApiHelper apiHelper = ApiHelper();
  List<ProductModel>? productListModel;
  RxInt pageCount = 1.obs;

  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  bool isNetworkError = false;
  bool isSuccess = false;

  Future<List<ProductModel>?> getPhotoData(
      {required BuildContext context, required int pageCount}) async {
    changeEmptyValue(false);
    changeLoadingValue(true);
    changeNetworkValue(false);
    changeErrorValue(false);
    changeSuccessValue(false);

    var url = 'https://jsonplaceholder.typicode.com/photos';

    await apiHelper.getProductDataApi(context: context, url: url, page: pageCount.toString())
        .then((result) async {
      try {
        if (result!= null) {
              result.isNotEmpty == true
              ? productListModel = result
              : changeEmptyValue(true);

          changeLoadingValue(false);
          changeSuccessValue(true);
        } else {
          changeLoadingValue(false);
          changeSuccessValue(false);
        }
      } catch (_) {
        changeSuccessValue(false);
        changeLoadingValue(false);
        changeErrorValue(true);
        print("Exception : $_");
      }
    });
    update();
  }

  void changeSuccessValue(bool value) {
    isSuccess = value;
    update();
  }

  void changeLoadingValue(bool value) {
    isLoading = value;
    update();
  }

  void changeEmptyValue(bool value) {
    isEmpty = value;
    update();
  }

  void changeNetworkValue(bool value) {
    isNetworkError = value;
    update();
  }

  void changeErrorValue(bool value) {
    isError = value;
    update();
  }
}
