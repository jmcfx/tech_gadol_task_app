import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_response_model.dart';

part 'product_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/products')
abstract class ProductClient {
  factory ProductClient(Dio dio, {String? baseUrl}) = _ProductClient;

  @GET('')
  Future<ProductResponseModel> getProducts(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );

  @GET('/search')
  Future<ProductResponseModel> searchProducts(
    @Query('q') String query,
    @Query('limit') int limit,
    @Query('skip') int skip,
  );

  @GET('/categories')
  Future<List<CategoryModel>> getCategories();

  @GET('/category/{name}')
  Future<ProductResponseModel> getProductsByCategory(
    @Path('name') String name,
    @Query('limit') int limit,
    @Query('skip') int skip,
  );

  @GET('/{id}')
  Future<ProductModel> getProductById(@Path('id') int id);
}
