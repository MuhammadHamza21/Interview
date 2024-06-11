// ignore_for_file: public_member_api_docs, sort_constructors_first
class UnitModel {
  final String productName;
  final int unitNo;
  UnitModel({
    required this.productName,
    required this.unitNo,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        productName: json['unitName'],
        unitNo: json['unitNo'],
      );
}
