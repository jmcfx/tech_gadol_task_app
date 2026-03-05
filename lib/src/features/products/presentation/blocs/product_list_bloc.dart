import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:tech_gadol_task_app/src/core/enums/view_state.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_categories.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products_by_category.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/search_products.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_event.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_state.dart';
import 'package:stream_transform/stream_transform.dart';

const _pageSize = 20;
const _debounceDuration = Duration(milliseconds: 500);

/// Debounce transformer for search events.
EventTransformer<E> _debounce<E>() {
  return (events, mapper) =>
      events.debounce(_debounceDuration).switchMap(mapper);
}

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProducts _getProducts;
  final SearchProducts _searchProducts;
  final GetCategories _getCategories;
  final GetProductsByCategory _getProductsByCategory;

  ProductListBloc({
    required GetProducts getProducts,
    required SearchProducts searchProducts,
    required GetCategories getCategories,
    required GetProductsByCategory getProductsByCategory,
  }) : _getProducts = getProducts,
       _searchProducts = searchProducts,
       _getCategories = getCategories,
       _getProductsByCategory = getProductsByCategory,
       super(const ProductListState()) {
    on<FetchProducts>(_onFetchProducts);
    on<LoadMoreProducts>(_onLoadMore, transformer: droppable());
    on<SearchQueryChanged>(_onSearchChanged, transformer: _debounce());
    on<CategorySelected>(_onCategorySelected);
    on<RetryFetch>(_onRetry);
  }

  // ── FetchProducts ──
  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: ViewState.loading));

    // Fetch categories in parallel
    final categoriesResult = await _getCategories(());
    categoriesResult.fold((_) {}, (data) {
      final (cats, _) = data;
      emit(state.copyWith(categories: cats));
    });

    await _fetchProducts(emit, skip: 0, isRefresh: true);
  }

  // ── LoadMore ──
  Future<void> _onLoadMore(
    LoadMoreProducts event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.hasReachedMax || state.paginationStatus.isLoading) return;

    emit(state.copyWith(paginationStatus: ViewState.loading));

    await _fetchProducts(
      emit,
      skip: state.currentSkip + _pageSize,
      isRefresh: false,
    );
  }

  // ── SearchQueryChanged ──
  Future<void> _onSearchChanged(
    SearchQueryChanged event,
    Emitter<ProductListState> emit,
  ) async {
    emit(
      state.copyWith(
        searchQuery: event.query,
        status: ViewState.loading,
        products: [],
        hasReachedMax: false,
        currentSkip: 0,
      ),
    );

    await _fetchProducts(emit, skip: 0, isRefresh: true);
  }

  // ── CategorySelected ──
  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<ProductListState> emit,
  ) async {
    final isSameCategory = state.selectedCategory == event.categorySlug;
    emit(
      state.copyWith(
        selectedCategory: () => isSameCategory ? null : event.categorySlug,
        status: ViewState.loading,
        products: [],
        hasReachedMax: false,
        currentSkip: 0,
      ),
    );

    await _fetchProducts(emit, skip: 0, isRefresh: true);
  }

  // ── RetryFetch ──
  Future<void> _onRetry(
    RetryFetch event,
    Emitter<ProductListState> emit,
  ) async {
    add(const FetchProducts());
  }

  // ── Unified fetch logic ──
  Future<void> _fetchProducts(
    Emitter<ProductListState> emit, {
    required int skip,
    required bool isRefresh,
  }) async {
    final query = state.searchQuery;
    final category = state.selectedCategory;

    // Determine which use case to call
    final result = await _resolveRequest(query, category, skip);

    result.fold(
      (failure) {
        if (isRefresh) {
          emit(
            state.copyWith(
              status: ViewState.error,
              errorMessage: () => failure.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              paginationStatus: ViewState.error,
              errorMessage: () => failure.message,
            ),
          );
        }
      },
      (data) {
        final (products, total, source) = data;
        final allProducts = isRefresh
            ? products
            : [...state.products, ...products];
        final hasReachedMax = allProducts.length >= total;

        emit(
          state.copyWith(
            products: allProducts,
            total: total,
            status: ViewState.success,
            paginationStatus: ViewState.idle,
            hasReachedMax: hasReachedMax,
            currentSkip: skip,
            errorMessage: () => null,
            dataSource: source,
          ),
        );
      },
    );
  }

  Future<dynamic> _resolveRequest(
    String query,
    String? category,
    int skip,
  ) async {
    if (query.isNotEmpty && category != null) {
      return _searchProducts(
        SearchProductsParams(query: query, limit: _pageSize, skip: skip),
      );
    } else if (query.isNotEmpty) {
      return _searchProducts(
        SearchProductsParams(query: query, limit: _pageSize, skip: skip),
      );
    } else if (category != null) {
      return _getProductsByCategory(
        GetProductsByCategoryParams(
          categorySlug: category,
          limit: _pageSize,
          skip: skip,
        ),
      );
    } else {
      return _getProducts(GetProductsParams(limit: _pageSize, skip: skip));
    }
  }
}
