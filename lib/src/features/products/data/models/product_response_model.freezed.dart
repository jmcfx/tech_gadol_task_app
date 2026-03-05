// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductResponseModel {

 List<ProductModel> get products; int get total; int get skip; int get limit;
/// Create a copy of ProductResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductResponseModelCopyWith<ProductResponseModel> get copyWith => _$ProductResponseModelCopyWithImpl<ProductResponseModel>(this as ProductResponseModel, _$identity);

  /// Serializes this ProductResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductResponseModel&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),total,skip,limit);

@override
String toString() {
  return 'ProductResponseModel(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductResponseModelCopyWith<$Res>  {
  factory $ProductResponseModelCopyWith(ProductResponseModel value, $Res Function(ProductResponseModel) _then) = _$ProductResponseModelCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products, int total, int skip, int limit
});




}
/// @nodoc
class _$ProductResponseModelCopyWithImpl<$Res>
    implements $ProductResponseModelCopyWith<$Res> {
  _$ProductResponseModelCopyWithImpl(this._self, this._then);

  final ProductResponseModel _self;
  final $Res Function(ProductResponseModel) _then;

/// Create a copy of ProductResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductResponseModel].
extension ProductResponseModelPatterns on ProductResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductResponseModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductModel> products,  int total,  int skip,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductResponseModel() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductModel> products,  int total,  int skip,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ProductResponseModel():
return $default(_that.products,_that.total,_that.skip,_that.limit);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductModel> products,  int total,  int skip,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ProductResponseModel() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductResponseModel implements ProductResponseModel {
  const _ProductResponseModel({final  List<ProductModel> products = const [], this.total = 0, this.skip = 0, this.limit = 0}): _products = products;
  factory _ProductResponseModel.fromJson(Map<String, dynamic> json) => _$ProductResponseModelFromJson(json);

 final  List<ProductModel> _products;
@override@JsonKey() List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int skip;
@override@JsonKey() final  int limit;

/// Create a copy of ProductResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductResponseModelCopyWith<_ProductResponseModel> get copyWith => __$ProductResponseModelCopyWithImpl<_ProductResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductResponseModel&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,skip,limit);

@override
String toString() {
  return 'ProductResponseModel(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductResponseModelCopyWith<$Res> implements $ProductResponseModelCopyWith<$Res> {
  factory _$ProductResponseModelCopyWith(_ProductResponseModel value, $Res Function(_ProductResponseModel) _then) = __$ProductResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<ProductModel> products, int total, int skip, int limit
});




}
/// @nodoc
class __$ProductResponseModelCopyWithImpl<$Res>
    implements _$ProductResponseModelCopyWith<$Res> {
  __$ProductResponseModelCopyWithImpl(this._self, this._then);

  final _ProductResponseModel _self;
  final $Res Function(_ProductResponseModel) _then;

/// Create a copy of ProductResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_ProductResponseModel(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
