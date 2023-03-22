// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodesHash() => r'203a8e3d4621fa0903919f39e40c7b3bf8c06381';

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
String _$currentEpisodesHash() => r'572576556ec587bc6e14d9861e41dc2803659c82';

/// See also [CurrentEpisodes].
@ProviderFor(CurrentEpisodes)
final currentEpisodesProvider =
    AutoDisposeAsyncNotifierProvider<CurrentEpisodes, List<Episode>>.internal(
  CurrentEpisodes.new,
  name: r'currentEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentEpisodes = AutoDisposeAsyncNotifier<List<Episode>>;
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
