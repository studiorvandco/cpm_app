import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:json_cache/json_cache.dart';
import 'package:localstorage/localstorage.dart';

class CacheManager {
  static final CacheManager _singleton = CacheManager._internal();

  factory CacheManager() {
    return _singleton;
  }

  CacheManager._internal();

  late final LocalStorage _storage;
  late final JsonCache _cache;

  Future<void> init() async {
    _storage = LocalStorage('cache');
    _cache = JsonCacheMem(JsonCacheLocalStorage(_storage));
  }

  void set(CacheKey cacheKey, List<BaseModel> models) {
    _cache.refresh(
      cacheKey.name,
      {for (final model in models) model.id.toString(): model.toJsonCache()},
    );
  }

  Future<bool> contains(CacheKey cacheKey) async {
    return _cache.contains(cacheKey.name);
  }

  Future<List<Model>> get<Model extends BaseModel>(
    CacheKey cacheKey,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    assert(Model != dynamic);

    final models = await _cache.value(cacheKey.name);

    return models == null ? [] : models.values.map((e) => constructor(e as Map<String, dynamic>)).toList();
  }

  Future<void> clear() async {
    await _cache.clear();
  }
}
