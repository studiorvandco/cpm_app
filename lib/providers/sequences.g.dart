// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sequencesHash() => r'd995cecb018ff08d899ae0105629d670b0bbe5da';

/// See also [Sequences].
@ProviderFor(Sequences)
final sequencesProvider =
    AutoDisposeAsyncNotifierProvider<Sequences, List<Sequence>>.internal(
  Sequences.new,
  name: r'sequencesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sequencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Sequences = AutoDisposeAsyncNotifier<List<Sequence>>;
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
