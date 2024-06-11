// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:interview/controller/app_cubit.dart';
import 'package:interview/controller/app_states.dart';
import 'package:interview/models/invoice_model.dart';
import 'package:interview/widgets/default_text_form_field.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  InvoiceDetailsScreen({
    Key? key,
    this.lineNo = 0,
  }) : super(key: key);
  final int lineNo;
  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  var productNameController = TextEditingController();

  var priceController = TextEditingController();

  var quantityController = TextEditingController();

  var totalController = TextEditingController();

  var expiryDateController = TextEditingController();
  List<DropdownMenuItem> itemsNumbers = [];
  String selectedItem = "600";
  int index = 0;
  inits() async {
    final appCubit = AppCubit.get(context);
    await appCubit.getInvoices();
    await appCubit.getUnits();
    if (widget.lineNo > 0) {
      for (int i = 0; i < appCubit.invoicesList.length; i++) {
        if (appCubit.invoicesList[i].lineNo == widget.lineNo) {
          setState(() {
            index = i;
            fillFields(appCubit.invoicesList[index]);
          });
        }
      }
    } else {
      fillFields(appCubit.invoicesList[index]);
    }
  }

  fillFields(InvoiceModel invoice) {
    productNameController.text = invoice.productName;
    priceController.text = invoice.price.toString();
    quantityController.text = invoice.quantity.toString();
    totalController.text = invoice.total.toString();
    expiryDateController.text = invoice.expiryDate.split(" ").first;
    setState(() {
      selectedItem = invoice.unitNo.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    inits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        final appCubit = AppCubit.get(context);
        return state is GettingInvoicesLoadingState ||
                state is GettingUnitsLoadingState
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product name",
                        ),
                        DefaultTextFormField(
                          controller: productNameController,
                          keyboardType: TextInputType.name,
                          onChanged: (String p) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Unit Number",
                            ),
                            Spacer(),
                            DropdownButton(
                              underline: const SizedBox(),
                              items: appCubit.unitsList.map((e) {
                                return DropdownMenuItem(
                                  value: e.unitNo,
                                  child: Text(e.unitNo.toString()),
                                );
                              }).toList(),
                              onChanged: (p) {
                                setState(() {
                                  selectedItem = p.toString();
                                });
                              },
                              // value: selectedItem,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Price",
                        ),
                        DefaultTextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {
                            totalController.text =
                                (int.parse(priceController.text) *
                                        int.parse(quantityController.text))
                                    .toString();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Quantity",
                        ),
                        DefaultTextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {
                            totalController.text =
                                (double.parse(priceController.text) *
                                        double.parse(quantityController.text))
                                    .toString();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total",
                        ),
                        DefaultTextFormField(
                          controller: totalController,
                          keyboardType: TextInputType.number,
                          enabled: false,
                          onChanged: (String p) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Expiry Date",
                        ),
                        DefaultTextFormField(
                          controller: expiryDateController,
                          keyboardType: TextInputType.number,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime(2024),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ).then((value) {
                              expiryDateController.text =
                                  '${value!.day}/${value.month}/${value.year}';
                            });
                          },
                          onChanged: (String p) {},
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  InvoiceModel invoice = InvoiceModel(
                                    lineNo: 0,
                                    productName: productNameController.text,
                                    unitNo: int.parse(selectedItem),
                                    price: double.parse(priceController.text),
                                    quantity:
                                        double.parse(quantityController.text),
                                    total: double.parse(totalController.text),
                                    expiryDate: expiryDateController.text,
                                  );
                                  appCubit.addInvoice(invoice);
                                },
                                child: Text(
                                  "New",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  InvoiceModel invoice = InvoiceModel(
                                    lineNo: appCubit.invoicesList[index].lineNo,
                                    productName: productNameController.text,
                                    unitNo: int.parse(selectedItem),
                                    price: double.parse(priceController.text),
                                    quantity:
                                        double.parse(quantityController.text),
                                    total: double.parse(totalController.text),
                                    expiryDate: expiryDateController.text,
                                  );
                                  appCubit.updateInvoice(invoice);
                                },
                                child: Text(
                                  "Save",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Back",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  appCubit.deleteInvoice(
                                    appCubit.invoicesList[index].lineNo,
                                  );
                                },
                                child: Text(
                                  "Delete",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (index > 0) {
                                    index--;
                                    fillFields(appCubit.invoicesList[index]);
                                  }
                                });
                              },
                              child: Text(
                                "<<",
                              ),
                            ),
                            Text(index.toString()),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (index <
                                      appCubit.invoicesList.length - 1) {
                                    index++;
                                    fillFields(appCubit.invoicesList[index]);
                                  }
                                });
                              },
                              child: Text(
                                ">>",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
