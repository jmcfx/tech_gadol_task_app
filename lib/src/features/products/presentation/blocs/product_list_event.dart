import 'package:equatable/equatable.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

/// Initial fetch event — loads first page of products + categories.
class FetchProducts extends ProductListEvent {
  const FetchProducts();
}

/// Triggered at the bottom of the list for pagination.
class LoadMoreProducts extends ProductListEvent {
  const LoadMoreProducts();
}

/// Fired on search text change (after debounce).
class SearchQueryChanged extends ProductListEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Fired when a category chip is tapped.
/// Pass `null` to clear the filter.
class CategorySelected extends ProductListEvent {
  final String? categorySlug;

  const CategorySelected(this.categorySlug);

  @override
  List<Object?> get props => [categorySlug];
}

/// Fired when the retry button is tapped after an error.
class RetryFetch extends ProductListEvent {
  const RetryFetch();
}
