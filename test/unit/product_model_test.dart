import 'package:flutter_test/flutter_test.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';

void main() {
  group('ProductModel', () {
    test('parses valid JSON with all fields', () {
      final json = _validProductJson();

      final model = ProductModel.fromJson(json);

      expect(model.id, 1);
      expect(model.title, 'Test Product');
      expect(model.description, 'A great product');
      expect(model.price, 29.99);
      expect(model.discountPercentage, 10.0);
      expect(model.rating, 4.5);
      expect(model.stock, 100);
      expect(model.brand, 'TestBrand');
      expect(model.category, 'electronics');
      expect(model.thumbnail, 'https://example.com/thumb.jpg');
      expect(model.images, ['https://example.com/img1.jpg']);
    });

    test('parses JSON with missing brand → defaults to null', () {
      final json = _validProductJson()..remove('brand');

      final model = ProductModel.fromJson(json);

      expect(model.brand, isNull);
    });

    test('parses JSON with missing images → defaults to empty list', () {
      final json = _validProductJson()..remove('images');

      final model = ProductModel.fromJson(json);

      expect(model.images, isEmpty);
    });

    test('parses JSON with missing price → defaults to 0.0', () {
      final json = _validProductJson()..remove('price');

      final model = ProductModel.fromJson(json);

      expect(model.price, 0.0);
    });

    test('parses JSON with missing title → defaults to empty string', () {
      final json = _validProductJson()..remove('title');

      final model = ProductModel.fromJson(json);

      expect(model.title, '');
    });
  });

  group('ProductEntity data validation', () {
    test('safeBrand returns brand when it is not null', () {
      final entity = _createEntity(brand: 'Nike');
      expect(entity.safeBrand, 'Nike');
    });

    test('safeBrand returns "Unknown brand" when brand is null', () {
      final entity = _createEntity(brand: null);
      expect(entity.safeBrand, 'Unknown brand');
    });

    test('safeBrand returns "Unknown brand" when brand is empty', () {
      final entity = _createEntity(brand: '');
      expect(entity.safeBrand, 'Unknown brand');
    });

    test('hasDiscount is true when discountPercentage > 0 and price > 0', () {
      final entity = _createEntity(price: 100, discountPercentage: 10);
      expect(entity.hasDiscount, isTrue);
    });

    test('hasDiscount is false when discountPercentage is 0', () {
      final entity = _createEntity(price: 100, discountPercentage: 0);
      expect(entity.hasDiscount, isFalse);
    });

    test('hasDiscount is false when price is 0', () {
      final entity = _createEntity(price: 0, discountPercentage: 10);
      expect(entity.hasDiscount, isFalse);
    });

    test('discountedPrice calculates correctly', () {
      final entity = _createEntity(price: 100, discountPercentage: 20);
      expect(entity.discountedPrice, 80.0);
    });

    test('isPriceValid is false for zero price', () {
      final entity = _createEntity(price: 0);
      expect(entity.isPriceValid, isFalse);
    });

    test('isPriceValid is false for negative price', () {
      final entity = _createEntity(price: -5);
      expect(entity.isPriceValid, isFalse);
    });

    test('isPriceValid is true for positive price', () {
      final entity = _createEntity(price: 29.99);
      expect(entity.isPriceValid, isTrue);
    });

    test('isInStock is true when stock > 0', () {
      final entity = _createEntity(stock: 5);
      expect(entity.isInStock, isTrue);
    });

    test('isInStock is false when stock is 0', () {
      final entity = _createEntity(stock: 0);
      expect(entity.isInStock, isFalse);
    });
  });
}

Map<String, dynamic> _validProductJson() => {
  'id': 1,
  'title': 'Test Product',
  'description': 'A great product',
  'price': 29.99,
  'discountPercentage': 10.0,
  'rating': 4.5,
  'stock': 100,
  'brand': 'TestBrand',
  'category': 'electronics',
  'thumbnail': 'https://example.com/thumb.jpg',
  'images': ['https://example.com/img1.jpg'],
};

ProductEntity _createEntity({
  int id = 1,
  String title = 'Test',
  String description = 'Desc',
  double price = 29.99,
  double discountPercentage = 0,
  double rating = 4.0,
  int stock = 10,
  String? brand = 'Brand',
  String category = 'cat',
  String thumbnail = 'https://example.com/thumb.jpg',
  List<String> images = const [],
}) {
  return ProductEntity(
    id: id,
    title: title,
    description: description,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    brand: brand,
    category: category,
    thumbnail: thumbnail,
    images: images,
  );
}
