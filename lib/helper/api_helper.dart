
import 'dart:convert';
import 'package:shopping_demo/utils/imports.dart';
import 'package:http/http.dart' as http;

class ApiHelper {

  Future<List<ProductModel>?> getProductDataApi(
      {context, required String url, required String page}) async {
    List<ProductModel>? result;

      try {
        final http.Response? response = await requestGetForApi(context: context, url: url,page: page);
        if (response?.body != null && response?.statusCode == 200) {
          result = (json.decode(response?.body ?? '') as List)
              .map((data){
                return ProductModel.fromJson(data);
          })
              .toList();
        }
        print("-----------Result => ${result?.length}");
        return result;
      } catch (e) {
        print("Exception_main1: $e");
        return result;
      }
  }





  Future<http.Response?> requestGetForApi({required context, String? url, required String page}) async {
    try {
      var furl = Uri.parse(url!);
      final response = await http.get(furl, headers: {
        'limit':"20",
        'page':page,
      });
      return response;
    } catch (error) {
      print("Exception_Main: $error");
      return null;
    }
  }
}
