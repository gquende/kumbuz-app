import 'package:equatable/equatable.dart';

class Income2 extends Equatable {
  int id;
  String description;

  Income2({required this.id, required this.description});
  @override
  List<Object?> get props => [id, description];
}