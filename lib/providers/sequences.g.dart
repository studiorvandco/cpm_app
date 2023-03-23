// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSequencesHash() => r'5e03f840740505b8c4a5765c12f94b15c0cb0290';

/// See also [CurrentSequences].
@ProviderFor(CurrentSequences)
final currentSequencesProvider =
    AutoDisposeAsyncNotifierProvider<CurrentSequences, List<Sequence>>.internal(
  CurrentSequences.new,
  name: r'currentSequencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSequencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSequences = AutoDisposeAsyncNotifier<List<Sequence>>;
String _$currentSequenceHash() => r'e07183703ecedddeccc80613c62fa03b342e5fcd';

/// See also [CurrentSequence].
@ProviderFor(CurrentSequence)
final currentSequenceProvider =
    AsyncNotifierProvider<CurrentSequence, Sequence>.internal(
  CurrentSequence.new,
  name: r'currentSequenceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSequenceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSequence = AsyncNotifier<Sequence>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
