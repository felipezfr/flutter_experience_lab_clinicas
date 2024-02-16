import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import 'attendent_desk_assignment_repository.dart';

class AttendentDeskAssignmentRepositoryImpl
    implements AttendentDeskAssignmentRepository {
  final RestClient restClient;

  AttendentDeskAssignmentRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Unit>> startService(int deskNumber) async {
    final result = await _clearDeskByUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await restClient.auth.post('/attendantDeskAssignment', data: {
          'user_id': '#userAuthRef',
          'desk_number': deskNumber,
          'date_created': DateTime.now().toIso8601String(),
          'status': 'Available',
        });
        return Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearDeskByUser() async {
    try {
      final desk = await _getDeskByUser();

      if (desk != null) {
        await restClient.auth.delete('/attendantDeskAssignment/${desk.id}');
      }

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao deletar numbero do guiche', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(data: List(firstOrNull: data)) = await restClient.auth.get(
      '/attendantDeskAssignment',
      queryParameters: {'user_id': '#userAuthRef'},
    );

    if (data == null) {
      return null;
    }
    return (id: data['id'] as String, deskNumber: data['desk_number'] as int);
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssigment() async {
    try {
      final Response(data: List(first: data)) = await restClient.auth
          .get('/attendantDeskAssignment', queryParameters: {
        'user_id': '#userAuthRef',
      });

      return Right(data['desk_number']);
    } on DioException catch (e, s) {
      log('Erro ao buscar numero do guiche', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
