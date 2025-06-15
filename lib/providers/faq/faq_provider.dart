import 'package:_29035f/model/faq.dart';
import 'package:_29035f/services/faq_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final faqSearchQueryProvider = StateProvider<String>((ref) => '');

final faqApiService = Provider<FaqApiService>((ref) => FaqApiService());

final faqTextControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final paginatedFaqProvider =
    StateNotifierProvider.autoDispose<
      PaginatedFaqNotifier,
      AsyncValue<List<FaqItem>>
    >((ref) => PaginatedFaqNotifier(ref));

class PaginatedFaqNotifier extends StateNotifier<AsyncValue<List<FaqItem>>> {
  PaginatedFaqNotifier(this.ref) : super(const AsyncLoading()) {
    fetchFaqs();
    ref.listen<String>(faqSearchQueryProvider, (prev, next) {
      _applyFilter(next);
    });
  }

  final Ref ref;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetching = false;
  final List<FaqItem> _allFaqs = [];

  void _applyFilter(String query) {
    state = AsyncData(filterFaqs(query));
  }

  Future<void> fetchFaqs() async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;

    try {
      final faqService = ref.read(faqApiService);
      final response = await faqService.fetchFaq(_currentPage);

      _allFaqs.addAll(response.data);
      _currentPage++;
      _hasMore = response.pagination.nextPageUrl != null;

      state = AsyncData(List.from(_allFaqs));
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetching = false;
    }
  }

  List<FaqItem> filterFaqs(String query) {
    if (query.isEmpty) return _allFaqs;
    return _allFaqs.where((faq) {
      final question = faq.question.toLowerCase();
      final answer = faq.answer.toLowerCase();
      return question.contains(query.toLowerCase()) ||
          answer.contains(query.toLowerCase());
    }).toList();
  }
}
