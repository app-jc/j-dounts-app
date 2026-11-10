// Resolves the discount label based on the provided product discount and an optional section override.
String? resolveDiscountLabel({
  required String? productDiscount,
  String? sectionOverride,
}) => sectionOverride ?? productDiscount;
