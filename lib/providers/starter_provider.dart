import 'package:cpm/models/starter_model/starter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'starter_provider.g.dart';

@riverpod
StarterModel starter(StarterRef ref) {
  return const StarterModel(label: 'This is a starter app');
}
