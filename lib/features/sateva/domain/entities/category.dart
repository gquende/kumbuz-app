import 'package:equatable/equatable.dart';

class Category extends Equatable {
  //int id;
  String uuid;
  String? userId;
  String name;
  String? color;
  String? iconUrl;
  String? type;
  double? value;
  Category(this.uuid, this.userId, this.name, this.color, this.iconUrl,
      this.value, this.type);

  @override
  // TODO: implement props
  List<Object?> get props => [uuid, userId, name, color, iconUrl, value, type];
}
