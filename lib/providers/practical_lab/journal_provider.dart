import 'package:_29035f/model/journal.dart';
import 'package:_29035f/model/journal_videos.dart';
import 'package:_29035f/services/journal_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

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

final journalVideoProvider =
    StateNotifierProvider.autoDispose<
      JournalVideoController,
      AsyncValue<JournalVideoModal>
    >((ref) => JournalVideoController(ref));

class JournalVideoController
    extends StateNotifier<AsyncValue<JournalVideoModal>> {
  JournalVideoController(this.ref) : super(const AsyncValue.loading()) {
    fetchJournal();
  }

  final Ref ref;

  Future<void> fetchJournal() async {
    state = const AsyncLoading();
    try {
      final journal = await ref.read(journalApiService).fetchJournalVideos();
      state = AsyncValue.data(journal);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final isVideoPlayingProvider = StateProvider<bool>((ref) => false);

final videoControllerProvider =
    StateNotifierProvider<
      VideoControllerNotifier,
      AsyncValue<VideoPlayerController?>
    >((ref) => VideoControllerNotifier(ref));

class VideoControllerNotifier
    extends StateNotifier<AsyncValue<VideoPlayerController?>> {
  VideoControllerNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  Future<void> initialize(String videoUrl) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    try {
      await controller.initialize();
      controller.play();
      controller.setLooping(false);

      controller.addListener(() {
        if (controller.value.position >= controller.value.duration &&
            !controller.value.isPlaying) {
          resetVideo(ref);
        }
      });

      state = AsyncData(controller);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void disposeController() {
    final controller = state.value;
    controller?.dispose();
    state = const AsyncLoading();
  }

  void resetVideo(Ref ref) {
    disposeController();
    ref.read(isVideoPlayingProvider.notifier).state = false;
  }
}
