import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/enums/view_state.dart';
import 'package:tech_gadol_task_app/src/core/errors/failure.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_categories.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products_by_category.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/search_products.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_bloc.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_event.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_state.dart';

// ── Mocks ──

class MockGetProducts extends Mock implements GetProducts {}

class MockSearchProducts extends Mock implements SearchProducts {}

class MockGetCategories extends Mock implements GetCategories {}

class MockGetProductsByCategory extends Mock implements GetProductsByCategory {}

void main() {
  late MockGetProducts mockGetProducts;
  late MockSearchProducts mockSearchProducts;
  late MockGetCategories mockGetCategories;
  late MockGetProductsByCategory mockGetProductsByCategory;
  late ProductListBloc bloc;

  final tProducts = [
    const ProductEntity(
      id: 1,
      title: 'Product 1',
      description: 'Desc',
      price: 10,
      discountPercentage: 0,
      rating: 4,
      stock: 5,
      category: 'cat',
      thumbnail: 'thumb',
      images: [],
    ),
  ];

  final tCategories = [
    const CategoryModel(slug: 'beauty', name: 'Beauty', url: ''),
  ];

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockSearchProducts = MockSearchProducts();
    mockGetCategories = MockGetCategories();
    mockGetProductsByCategory = MockGetProductsByCategory();

    bloc = ProductListBloc(
      getProducts: mockGetProducts,
      searchProducts: mockSearchProducts,
      getCategories: mockGetCategories,
      getProductsByCategory: mockGetProductsByCategory,
    );
  });

  setUpAll(() {
    registerFallbackValue(const GetProductsParams());
    registerFallbackValue(const SearchProductsParams(query: ''));
    registerFallbackValue(const GetProductsByCategoryParams(categorySlug: ''));
    registerFallbackValue(());
  });

  tearDown(() => bloc.close());

  group('FetchProducts', () {
    blocTest<ProductListBloc, ProductListState>(
      'emits [loading, loaded] when FetchProducts succeeds',
      build: () {
        when(
          () => mockGetCategories(any()),
        ).thenAnswer((_) async => Right((tCategories, DataSource.network)));
        when(
          () => mockGetProducts(any()),
        ).thenAnswer((_) async => Right((tProducts, 1, DataSource.network)));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchProducts()),
      expect: () => [
        // loading state
        isA<ProductListState>().having(
          (s) => s.status,
          'status',
          ViewState.loading,
        ),
        // categories loaded
        isA<ProductListState>().having(
          (s) => s.categories,
          'categories',
          tCategories,
        ),
        // products loaded
        isA<ProductListState>()
            .having((s) => s.status, 'status', ViewState.success)
            .having((s) => s.products, 'products', tProducts)
            .having((s) => s.total, 'total', 1),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'emits [loading, error] when FetchProducts fails',
      build: () {
        when(
          () => mockGetCategories(any()),
        ).thenAnswer((_) async => const Right((<CategoryModel>[], DataSource.network)));
        when(() => mockGetProducts(any())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchProducts()),
      expect: () => [
        // loading state
        isA<ProductListState>().having(
          (s) => s.status,
          'status',
          ViewState.loading,
        ),
        // error state (categories Right([]) causes no state change since initial is already [])
        isA<ProductListState>()
            .having((s) => s.status, 'status', ViewState.error)
            .having((s) => s.errorMessage, 'errorMessage', 'Server error'),
      ],
    );
  });

  group('CategorySelected', () {
    blocTest<ProductListBloc, ProductListState>(
      'emits loading → success when a category is selected',
      build: () {
        when(
          () => mockGetProductsByCategory(any()),
        ).thenAnswer((_) async => Right((tProducts, 1, DataSource.network)));
        return bloc;
      },
      act: (bloc) => bloc.add(const CategorySelected('beauty')),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.status, 'status', ViewState.loading)
            .having((s) => s.selectedCategory, 'selectedCategory', 'beauty'),
        isA<ProductListState>()
            .having((s) => s.status, 'status', ViewState.success)
            .having((s) => s.products, 'products', tProducts),
      ],
    );
  });
}
