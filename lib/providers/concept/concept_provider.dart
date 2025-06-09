import 'dart:developer';

import 'package:_29035f/model/concept.dart';
import 'package:_29035f/services/concept_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conceptApiService = Provider((ref) => ConceptApiService());

final conceptListProvider =
    AsyncNotifierProvider<ConceptListNotifier, List<ConceptItem>>(
      ConceptListNotifier.new,
    );

class ConceptListNotifier extends AsyncNotifier<List<ConceptItem>> {
  @override
  Future<List<ConceptItem>> build() async {
    final apiService = ref.read(conceptApiService);
    final concepts = await apiService.fetchConcepts();
    log(
      'ConceptListNotifier: Initial data loaded. Number of items: ${concepts.length}',
    );
    for (var item in concepts) {
      log('  Initial item: ${item.header}, isExpanded: ${item.isExpanded}');
    }
    return concepts;
  }

  void togglePanel(int panelIndex, bool isOpening) {
    if (state is AsyncData) {
      final currentList = state.value!;
      final updatedList = [
        for (int i = 0; i < currentList.length; i++)
          currentList[i].copyWith(
            isExpanded: i == panelIndex ? isOpening : false,
          ),
      ];

      state = AsyncData(updatedList);
    } else {
      log('ConceptListNotifier: State is not AsyncData, cannot toggle.');
    }
  }
}
