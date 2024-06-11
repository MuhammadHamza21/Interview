import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/controller/app_cubit.dart';
import 'package:interview/controller/app_states.dart';
import 'package:interview/methods/navigate_to.dart';
import 'package:interview/screens/invoice_details_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final appCubit = AppCubit.get(context);
          return state is GettingInvoicesLoadingState
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          InvoiceDetailsScreen(
                            lineNo: appCubit.invoicesList[index].lineNo,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              appCubit.invoicesList[index].productName,
                            ),
                            Text(
                              "Price ${appCubit.invoicesList[index].price}",
                            ),
                            Text(
                              "Quantity ${appCubit.invoicesList[index].quantity}",
                            ),
                            Text(
                              "Total ${appCubit.invoicesList[index].total}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: appCubit.invoicesList.length,
                );
        },
      ),
    );
  }
}
