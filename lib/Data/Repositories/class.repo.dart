import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Class/Class.model.dart';

class ClassRepo extends FirestoreRepo<Class> {
  ClassRepo()
      : super(
          'Class',
        );

  @override
  Class? toModel(Map<String, dynamic>? item) => Class.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Class? item) => item?.toMap() ?? {};
}
