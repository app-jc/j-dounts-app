String? resolveDiscountLabel({
  required String? productDiscount,
  String? sectionOverride,
}) => sectionOverride ?? productDiscount;
