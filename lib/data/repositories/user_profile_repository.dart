import 'package:english_pocket_teacher/data/datasources/user_profile_datasource.dart';
import 'package:english_pocket_teacher/data/models/user_profile_model.dart';

class UserProfileRepository {
  final UserProfileDataSource _dataSource;

  UserProfileRepository(this._dataSource);

  Future<UserProfile?> getUserProfile() async {
    return _dataSource.getUserProfile();
  }

  Future<void> initializeProfile() async {
    final existing = await _dataSource.getUserProfile();
    if (existing == null) {
      await _dataSource.createUserProfile();
    }
  }

  Future<int> updateProfile(UserProfile profile) async {
    return _dataSource.updateUserProfile(profile);
  }

  Future<void> addXP(int amount) async {
    return _dataSource.addXP(amount);
  }
}
