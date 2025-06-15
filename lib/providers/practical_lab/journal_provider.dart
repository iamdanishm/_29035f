import 'package:_29035f/model/journal.dart';
import 'package:_29035f/services/journal_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalApiService = StateProvider<JournalApiService>(
  (ref) => JournalApiService(),
);

final journalProvider =
    StateNotifierProvider.autoDispose<
      JournalController,
      AsyncValue<JournalModel>
    >((ref) => JournalController(ref));

class JournalController extends StateNotifier<AsyncValue<JournalModel>> {
  JournalController(this.ref) : super(const AsyncValue.loading()) {
    fetchJournal();
  }

  final Ref ref;

  Future<void> fetchJournal() async {
    state = const AsyncLoading();
    try {
      final journal = await ref.read(journalApiService).fetchJournal();
      state = AsyncValue.data(journal);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
