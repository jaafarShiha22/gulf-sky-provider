import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/entities/order/order_item_entity.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/orders/orders_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../domain/entities/add_request/maintenance/order_response_entity.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final PagingController<int, OrderResponseEntity> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    BlocProvider.of<OrdersCubit>(context).getOrders(
      page: 0,
      pagingController: _pagingController,
    );
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<OrdersCubit>(context).getOrders(
        page: pageKey,
        pagingController: _pagingController,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.orders,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            );
          } else if (state is OrdersSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: PagedListView<int, OrderResponseEntity>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<OrderResponseEntity>(
                    itemBuilder: (context, orderItem, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        onTap: () {

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.id}: ${orderItem.id}',
                                    style: AppTextStyle.interRegularBlack,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.status}: ${orderItem.state}',
                                        style: AppTextStyle.interSmallBlack,
                                      ),
                                    ],
                                  ),
                                  if (orderItem.visitDate != null)
                                  Text(
                                    '${AppLocalizations.of(context)!.visitDate}: ${DateFormat(
                                      AppLocalizations.of(context)!.localeName == 'en' ? 'yyyy-MM-dd HH:MM' : 'HH:MM yyyy-MM-dd',
                                    ).format(orderItem.visitDate!)}',
                                    style: AppTextStyle.interSmallBlack,
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          else if (state is OrdersFailure){
            ToastUtils.showToast(state.errMessage);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
