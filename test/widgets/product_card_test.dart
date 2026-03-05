import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_theme.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/product_card.dart';

void main() {
  const product = ProductEntity(
    id: 1,
    title: 'Flutter Sneakers',
    description: 'Premium sneakers',
    price: 120.00,
    discountPercentage: 15.0,
    rating: 4.5,
    stock: 25,
    brand: 'DartWear',
    category: 'shoes',
    thumbnail: '',
    images: [],
  );

  const productNoDiscount = ProductEntity(
    id: 2,
    title: 'Basic Shoe',
    description: 'A shoe',
    price: 50.00,
    discountPercentage: 0,
    rating: 3.0,
    stock: 0,
    brand: 'NoBrand',
    category: 'shoes',
    thumbnail: '',
    images: [],
  );

  Widget createWidget({
    ProductEntity p = product,
    VoidCallback? onTap,
    bool isSelected = false,
  }) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: SingleChildScrollView(
          child: ProductCard(
            product: p,
            onTap: onTap ?? () {},
            isSelected: isSelected,
          ),
        ),
      ),
    );
  }

  group('ProductCard', () {
    testWidgets('renders product title', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('Flutter Sneakers'), findsOneWidget);
    });

    testWidgets('renders product brand', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('DartWear'), findsOneWidget);
    });

    testWidgets('shows discount badge when product has discount', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());
      // Discount text appears in both the card badge and PriceTag,
      // so we just verify at least one is present.
      expect(find.text('-15%'), findsWidgets);
    });

    testWidgets('does NOT show discount badge when no discount', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget(p: productNoDiscount));
      expect(find.text('-0%'), findsNothing);
    });

    testWidgets('renders "In Stock" badge when stock > 0', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('In Stock'), findsOneWidget);
    });

    testWidgets('renders "Out of Stock" badge when stock is 0', (tester) async {
      await tester.pumpWidget(createWidget(p: productNoDiscount));
      expect(find.text('Out of Stock'), findsOneWidget);
    });

    testWidgets('calls onTap when card is tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(createWidget(onTap: () => tapped = true));
      await tester.tap(find.byType(ProductCard));
      expect(tapped, isTrue);
    });
  });
}
