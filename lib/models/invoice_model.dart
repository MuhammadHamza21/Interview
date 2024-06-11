// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvoiceModel {
  final int lineNo;
  final String productName;
  final int unitNo;
  final double price;
  final double quantity;
  final double total;
  final String expiryDate;
  InvoiceModel({
    required this.lineNo,
    required this.productName,
    required this.unitNo,
    required this.price,
    required this.quantity,
    required this.total,
    required this.expiryDate,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        lineNo: json['lineNo'],
        productName: json['productName'],
        unitNo: json['UnitNo'],
        price: json['price'].toDouble(),
        quantity: json['quantity'].toDouble(),
        total: json['total'].toDouble(),
        expiryDate: json['expiryDate'],
      );
}
