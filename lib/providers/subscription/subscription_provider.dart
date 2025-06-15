import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCurrencyProvider = StateProvider<String>((ref) => "INR");

final currencyRatesProvider = Provider<Map<String, double>>((ref) {
  return {"INR": 1.0, "USD": 0.012, "NZD": 0.02};
});

final convertedPriceProvider = Provider.family<String, String>((ref, inrPrice) {
  final selectedCurrency = ref.watch(selectedCurrencyProvider);
  final rates = ref.watch(currencyRatesProvider);

  double priceInINR = double.tryParse(inrPrice.replaceAll(',', '')) ?? 0;
  double rate = rates[selectedCurrency] ?? 1.0;
  double converted = priceInINR * rate;

  switch (selectedCurrency) {
    case 'USD':
      return '\$${converted.floor()}';
    case 'NZD':
      return '\$${converted.floor()}';
    case 'INR':
    default:
      return '₹$inrPrice';
  }
});
