import 'package:home_info/data/data_sources/shared_storage.service.dart';
import 'package:home_info/domain/repository/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  StorageRepositoryImpl(this.storageService);
  final SharedStorageService storageService;

  @override
  Future<dynamic> loadStorageData(String key, {dynamic defaultValue}) async {
    try {
      return await storageService.loadStorageData(key) ?? defaultValue;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveStorageData(String key, dynamic data) async {
    try {
      await storageService.saveStorageData(key, data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
