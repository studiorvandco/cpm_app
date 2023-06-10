// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodesHash() => r'6543e6afe7ccebc89f908e2abfa641caa8773ca1';

/// See also [Episodes].
@ProviderFor(Episodes)
final episodesProvider =
    AutoDisposeAsyncNotifierProvider<Episodes, List<Episode>>.internal(
  Episodes.new,
  name: r'episodesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$episodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Episodes = AutoDisposeAsyncNotifier<List<Episode>>;
String _$currentEpisodeHash() => r'90a6c8b285fa36d0985750fb92de61ef0e110c36';

/// See also [CurrentEpisode].
@ProviderFor(CurrentEpisode)
final currentEpisodeProvider =
    AsyncNotifierProvider<CurrentEpisode, Episode>.internal(
  CurrentEpisode.new,
  name: r'currentEpisodeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentEpisodeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentEpisode = AsyncNotifier<Episode>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
