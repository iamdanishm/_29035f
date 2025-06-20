import 'package:_29035f/model/daily_gps_today.dart';
import 'package:_29035f/services/daily_gps_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyGpsTodayProvider = StateProvider<DailyGpsService>(
  (ref) => DailyGpsService(),
);

final dailyGpsProvider = FutureProvider<DailyGpsTodayModal>(
  (ref) => ref.watch(dailyGpsTodayProvider).fetch(),
);

final dailyGPSControllerNotifierProvider =
    StateNotifierProvider<
      DailyGPSControllerNotifier,
      AsyncValue<DailyGpsTodayModal>
    >((ref) => DailyGPSControllerNotifier(ref));

class DailyGPSControllerNotifier
    extends StateNotifier<AsyncValue<DailyGpsTodayModal>> {
  DailyGPSControllerNotifier(this.ref) : super(AsyncValue.loading()) {
    fetchDailyGps();
  }

  final Ref ref;

  Future<void> fetchDailyGps() async {
    try {
      final response = await ref.read(dailyGpsTodayProvider).fetch();
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void toggleCheckBox(int index, bool value) {
    final currentState = state.value;
    if (currentState == null) return;

    final updatedList = [...currentState.data];
    updatedList[index] = updatedList[index].copyWith(isCheck: value);

    state = AsyncValue.data(currentState.copyWith(data: updatedList));
  }
}
