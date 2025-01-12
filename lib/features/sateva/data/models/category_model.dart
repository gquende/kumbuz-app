import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
@Entity(tableName: "categories")
class CategoryModel extends Category {
  @PrimaryKey(autoGenerate: true)
  int id;
  //String? type;

  CategoryModel(this.id, String uuid, String userId, String name, String color,
      String iconUrl, double value, String type)
      : super(uuid, userId, name, color, iconUrl, value, type);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

List<CategoryModel> mockCategories = [
  CategoryModel(1, "1", "", "Alimentação", "0xff90e2e3", "", 2000, "expense"),
  CategoryModel(2, "2", "", "Transporte", "0xff90e2e3", "", 3000, "expense"),
  CategoryModel(3, "3", "", "Diversão", "0xff90e2e3", "", 3000, "expense"),
  CategoryModel(4, "4", "", "Presentes", "0xff90e2e3", "", 4000, "expense"),
  CategoryModel(5, "5", "", "Casa", "0xff90e2e3", "", 5000, "expense")
];
