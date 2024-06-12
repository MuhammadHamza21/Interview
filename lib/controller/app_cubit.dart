import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/controller/app_states.dart';
import 'package:interview/models/invoice_model.dart';
import 'package:interview/models/unit_model.dart';
import 'package:sql_conn/sql_conn.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  List<InvoiceModel> invoicesList = [];
  List<UnitModel> unitsList = [];
  final sqlConnet = SqlConn;
  Future connectToDataBase() async {
    emit(ConnectingToDatabaseLoadingState());
    await SqlConn.connect(
      ip: "192.168.1.1",
      port: "1433",
      databaseName: "Interview",
      username: "sa",
      password: "123456",
    ).then((value) {
      emit(ConnectingToDatabaseSuccessState());
    }).catchError((onError) {
      emit(ConnectingToDatabaseErrorState());
    });
  }

  Future getInvoices({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(GettingInvoicesRefreshState());
    } else {
      emit(GettingInvoicesLoadingState());
    }

    await SqlConn.readData("select * from InvoiceDetails").then((value) {
      var data = jsonDecode(value);
      invoicesList = List<InvoiceModel>.from(
          (data as List).map((e) => InvoiceModel.fromJson(e)));
      emit(GettingInvoicesSuccessState());
    }).catchError((onError) {
      emit(GettingInvoicesErrorState());
    });
  }

  Future getUnits() async {
    emit(GettingUnitsLoadingState());
    await SqlConn.readData("select * from Unit").then((value) {
      var data = jsonDecode(value);
      unitsList = List<UnitModel>.from(
          (data as List).map((e) => UnitModel.fromJson(e)));
      emit(GettingUnitsSuccessState());
    }).catchError((onError) {
      emit(GettingUnitsErrorState());
    });
  }

  Future updateInvoice(InvoiceModel invoice) async {
    emit(UpdatingInvoiceLoadingState());
    await SqlConn.writeData(
      "update InvoiceDetails set productName = '${invoice.productName}', UnitNo = ${invoice.unitNo}, price = ${invoice.price}, quantity = ${invoice.quantity}, total = ${invoice.total}, expiryDate = '${invoice.expiryDate} 00:00:00.000' where [lineNo] = ${invoice.lineNo}",
    ).then((value) {
      emit(UpdatingInvoiceSuccessState());
    }).catchError((onError) {
      emit(UpdatingInvoiceErrorState());
    });
  }

  Future addInvoice(InvoiceModel invoice) async {
    emit(AddingInvoiceLoadingState());
    await SqlConn.writeData(
      "insert into InvoiceDetails (productName, UnitNo, price, quantity, total, expiryDate) values ('${invoice.productName}', ${invoice.unitNo}, ${invoice.price}, ${invoice.quantity}, ${invoice.total}, '${invoice.expiryDate} 00:00:00.000')",
    ).then((value) {
      emit(AddingInvoiceSuccessState());
    }).catchError((onError) {
      emit(AddingInvoiceErrorState());
    });
  }

  Future deleteInvoice(int invoiceNo) async {
    emit(DeletingInvoiceLoadingState());
    await SqlConn.writeData(
      "delete from InvoiceDetails where [lineNo] = $invoiceNo",
    ).then((value) {
      // invoicesList.removeWhere((invoice) => invoice.lineNo == invoiceNo);
      emit(DeletingInvoiceSuccessState());
    }).catchError((onError) {
      emit(DeletingInvoiceErrorState());
    });
  }
}
