import 'package:equatable/equatable.dart';
import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/enums/view_state.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';

class ProductListState extends Equatable {
  final List<ProductEntity> products;
  final List<CategoryModel> categories;
  final ViewState status;
  final ViewState paginationStatus;
  final String searchQuery;
  final String? selectedCategory;
  final bool hasReachedMax;
  final String? errorMessage;
  final int currentSkip;
  final int total;
  final DataSource dataSource;

  const ProductListState({
    this.products = const [],
    this.categories = const [],
    this.status = ViewState.idle,
    this.paginationStatus = ViewState.idle,
    this.searchQuery = '',
    this.selectedCategory,
    this.hasReachedMax = false,
    this.errorMessage,
    this.currentSkip = 0,
    this.total = 0,
    this.dataSource = DataSource.network,
  });

  ProductListState copyWith({
    List<ProductEntity>? products,
    List<CategoryModel>? categories,
    ViewState? status,
    ViewState? paginationStatus,
    String? searchQuery,
    String? Function()? selectedCategory,
    bool? hasReachedMax,
    String? Function()? errorMessage,
    int? currentSkip,
    int? total,
    DataSource? dataSource,
  }) {
    return ProductListState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory != null
          ? selectedCategory()
          : this.selectedCategory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      currentSkip: currentSkip ?? this.currentSkip,
      total: total ?? this.total,
      dataSource: dataSource ?? this.dataSource,
    );
  }

  @override
  List<Object?> get props => [
    products,
    categories,
    status,
    paginationStatus,
    searchQuery,
    selectedCategory,
    hasReachedMax,
    errorMessage,
    currentSkip,
    total,
    dataSource,
  ];
}
