import 'package:_29035f/model/concept.dart';
import 'package:_29035f/services/concept_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conceptSearchQueryProvider = StateProvider<String>((ref) => '');

final conceptApiService = Provider<ConceptApiService>(
  (ref) => ConceptApiService(),
);

final conceptTextControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

final paginatedConceptProvider =
    StateNotifierProvider<
      PaginatedConceptNotifier,
      AsyncValue<List<ConceptItem>>
    >((ref) => PaginatedConceptNotifier(ref));

class PaginatedConceptNotifier
    extends StateNotifier<AsyncValue<List<ConceptItem>>> {
  PaginatedConceptNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchConcepts();
    ref.listen<String>(conceptSearchQueryProvider, (previous, next) {
      _applyFilter(next);
    });
  }

  final Ref ref;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetching = false;
  final List<ConceptItem> _allConcepts = [];

  void _applyFilter(String query) {
    state = AsyncData(filterConcepts(query));
  }

  List<ConceptItem> filterConcepts(String query) {
    if (query.isEmpty) return _allConcepts;
    return _allConcepts.where((concept) {
      final title = concept.title.toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();
  }

  Future<void> fetchConcepts() async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;

    try {
      final conceptService = ref.read(conceptApiService);
      final response = await conceptService.fetch(_currentPage);

      _allConcepts.addAll(response.data);
      _currentPage++;
      _hasMore = response.pagination.nextPageUrl != null;
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetching = false;
    }
  }
}
