const String _mmkSuffix = 'MMK';
final RegExp _thousandsBoundary = RegExp(r'\B(?=(\d{3})+(?!\d))');

String formatMmk(int amount) {
  final sign = amount < 0 ? '-' : '';
  final groupedAmount = amount.abs().toString().replaceAllMapped(
    _thousandsBoundary,
    (_) => ',',
  );
  return '$sign$groupedAmount $_mmkSuffix';
}
