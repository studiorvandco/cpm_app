import 'package:collection/collection.dart';

import '../../models/base_model.dart';
import '../service.dart';

abstract class SelectService extends Service {
  Future<List<Model>> select<Model extends BaseModel>(
    List data,
    Model Function(Map<String, dynamic>) constructor, {
    addNumberByIndex = false,
  }) async {
    List<Model> result = [];
    data.forEachIndexed((index, element) {
      if (addNumberByIndex) {
        element.addAll({'number': ++index});
      }
      result.add(constructor(element));
    });

    return result;
  }

  Future<Model> selectSingle<Model extends BaseModel>(
    data,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    return constructor(data);
  }
}
