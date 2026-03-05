import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/enums/view_state.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_product_by_id.dart';

// ── State ──

class ProductDetailState extends Equatable {
  final ViewState status;
  final ProductEntity? product;
  final String? errorMessage;
  final DataSource dataSource;

  const ProductDetailState({
    this.status = ViewState.idle,
    this.product,
    this.errorMessage,
    this.dataSource = DataSource.network,
  });

  ProductDetailState copyWith({
    ViewState? status,
    ProductEntity? product,
    String? Function()? errorMessage,
    DataSource? dataSource,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
      errorMessage:
          errorMessage != null ? errorMessage() : this.errorMessage,
      dataSource: dataSource ?? this.dataSource,
    );
  }

  @override
  List<Object?> get props => [status, product, errorMessage, dataSource];
}

// ── Cubit ──

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductById _getProductById;

  ProductDetailCubit({required GetProductById getProductById})
      : _getProductById = getProductById,
        super(const ProductDetailState());

  Future<void> fetchProduct(int id) async {
    emit(state.copyWith(status: ViewState.loading));

    final result = await _getProductById(id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewState.error,
        errorMessage: () => failure.message,
      )),
      (data) {
        final (product, source) = data;
        emit(state.copyWith(
          status: ViewState.success,
          product: product,
          errorMessage: () => null,
          dataSource: source,
        ));
      },
    );
  }

  /// Load a product that's already in memory (from the list) for instant display.
  void showProduct(ProductEntity product) {
    emit(ProductDetailState(
      status: ViewState.success,
      product: product,
    ));
  }
}
