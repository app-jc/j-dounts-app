import 'package:equatable/equatable.dart';

final class Product extends Equatable {
  const Product({
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.discountLabel,
    required this.description,
    required this.image,
  });

  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String? discountLabel;
  final String description;
  final String image;

  @override
  List<Object?> get props => [
    code,
    name,
    priceMmk,
    isNew,
    discountLabel,
    description,
    image,
  ];
}
