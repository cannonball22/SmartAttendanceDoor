import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Grade/grade.model.dart';

class GradeRepo extends FirestoreRepo<Grade> {
  GradeRepo()
      : super(
          'Grades',
        );

  @override
  Grade? toModel(Map<String, dynamic>? item) => Grade.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Grade? item) => item?.toMap() ?? {};
}
