import 'package:equatable/equatable.dart';

import 'package:j_dounts_app/core/member/domain/member.dart';

final class HomeData extends Equatable {
  HomeData({
    required this.member,
    required List<HomeBanner> banners,
    required List<HomeSection> sections,
    required List<HomeShop> shops,
  }) : banners = List.unmodifiable(banners),
       sections = List.unmodifiable(sections),
       shops = List.unmodifiable(shops);

  final Member? member;
  final List<HomeBanner> banners;
  final List<HomeSection> sections;
  final List<HomeShop> shops;

  @override
  List<Object?> get props => [member, banners, sections, shops];
}

final class HomeBanner extends Equatable {
  const HomeBanner({
    required this.id,
    required this.title,
    required this.image,
    required this.target,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final String image;
  final String? target;
  final int sortOrder;

  @override
  List<Object?> get props => [id, title, image, target, sortOrder];
}

final class HomeSection extends Equatable {
  HomeSection({
    required this.id,
    required this.title,
    required this.type,
    required this.layoutStyle,
    required this.sortOrder,
    required this.seeAll,
    required List<HomeProduct> products,
  }) : products = List.unmodifiable(products);

  final String id;
  final String title;
  final String type;
  final String layoutStyle;
  final int sortOrder;
  final bool seeAll;
  final List<HomeProduct> products;

  @override
  List<Object?> get props => [
    id,
    title,
    type,
    layoutStyle,
    sortOrder,
    seeAll,
    products,
  ];
}

final class HomeProduct extends Equatable {
  const HomeProduct({
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.discountLabel,
    required this.discountOverride,
    required this.description,
    required this.image,
    required this.sortOrder,
  });

  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String? discountLabel;
  final String? discountOverride;
  final String description;
  final String image;
  final int sortOrder;

  @override
  List<Object?> get props => [
    code,
    name,
    priceMmk,
    isNew,
    discountLabel,
    discountOverride,
    description,
    image,
    sortOrder,
  ];
}

final class HomeShop extends Equatable {
  const HomeShop({
    required this.id,
    required this.name,
    required this.photo,
    required this.sortOrder,
  });

  final String id;
  final String name;
  final String photo;
  final int sortOrder;

  @override
  List<Object?> get props => [id, name, photo, sortOrder];
}
