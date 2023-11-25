import 'package:banner_listtile/banner_listtile.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/config/routes/app_routes.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';
import 'package:gulf_sky_provider/core/utils/extensions/list_extension.dart';
import 'package:gulf_sky_provider/core/utils/show_toast.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/packages/packages_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/rent_contract_info/rent_contract_info_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/enums/payment_type.dart';
import '../../../domain/entities/client/contract_active_entity.dart';
import '../../../domain/usecases/packages/subscribe_package_usecase.dart';
import '../../../domain/usecases/packages/unsubscribe_package_usecase.dart';
import '../../blocs/packages/packages_event.dart';
import '../../blocs/packages/packages_state.dart';

class PackagesView extends StatefulWidget {
  const PackagesView({Key? key}) : super(key: key);

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  @override
  void initState() {
    BlocProvider.of<PackagesBloc>(context).add(const GetMaintenancePackages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.packages,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<RentContractInfoCubit, RentContractInfoState>(
          listener: (context, state) {
            if (state is RentContractInfoLoading) {
              EasyLoading.show(status: AppLocalizations.of(context)!.loading);
            } else if (state is RentContractInfoSuccess) {
              BlocProvider.of<PackagesBloc>(context).add(const GetMaintenancePackages());
            } else if (state is RentContractInfoFailure) {
              EasyLoading.dismiss();
              ToastUtils.showToast(state.errMessage);
            }
          },
          child: BlocConsumer<PackagesBloc, PackagesState>(
            listener: (context, state) {
              if (state is SubscribePackageLoading || state is UnsubscribePackageLoading) {
                EasyLoading.show(status: AppLocalizations.of(context)!.loading);
              } else if (state is SubscribePackageSucceeded) {
                BlocProvider.of<RentContractInfoCubit>(context).getContractAndRent();
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    backgroundColor: AppColors.orange,
                    title: '${AppLocalizations.of(context)!.info}!',
                    text: AppLocalizations.of(context)!.youHaveToContinueWithPaymentToGetBenefitOfThisPackage,
                    confirmBtnText: AppLocalizations.of(context)!.continueToPayment,
                    confirmBtnColor: AppColors.orange,
                    onConfirmBtnTap: () {
                      GoRouter.of(context).push(AppRoutes.paymentView, extra: {
                        'id': BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.contractActive.first.id,
                        'price': state.subscribedPackageEntity.price,
                        'payment_type': PaymentType.subscribeInPackage,
                      });
                    },
                    showCancelBtn: true,
                    cancelBtnText: AppLocalizations.of(context)!.notNow,
                    onCancelBtnTap: () {},
                    cancelBtnTextStyle: AppTextStyle.interSmallBoldOrange,
                    confirmBtnTextStyle: AppTextStyle.interSmallBoldWhite);
              } else if (state is SubscribePackageFailed) {
                EasyLoading.dismiss();
                ToastUtils.showToast(state.errorMsg);
              } else if (state is UnsubscribePackageSucceeded) {
                BlocProvider.of<RentContractInfoCubit>(context).getContractAndRent();
              } else if (state is UnsubscribePackageFailed) {
                EasyLoading.dismiss();
                ToastUtils.showToast(state.errorMsg);
              }
            },
            builder: (context, state) {
              if (state is GetMaintenancePackagesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.orange,
                  ),
                );
              }
              if (state is GetMaintenancePackagesSucceeded) {
                ContractActiveEntity? activeContract =
                    BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.contractActive.firstOrNull;
                bool isAlreadySubscribed = activeContract?.packages.firstOrNull?.id != null;
                return SingleChildScrollView(
                  child: Column(
                    children: state.packages
                        .map(
                          (package) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  BannerListTile(
                                    backgroundColor: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(16),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              package.name,
                                              style: AppTextStyle.interLargeBoldOrange,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            package.description,
                                            style: AppTextStyle.interSmallBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                    bannerColor: AppColors.orange,
                                    bannerSize: 100,
                                    bannerPosition: BannerPosition.topLeft,
                                    bannerText: '${package.price} ${AppLocalizations.of(context)!.aed}',
                                    bannerTextColor: AppColors.white,
                                  ),
                                  () {
                                    if (isAlreadySubscribed) {
                                      if (activeContract!.packages.first.id == package.id) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(color: Colors.white, width: 1.5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              if (activeContract.state == 'Pending') // No paid
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            GoRouter.of(context).push(AppRoutes.paymentView, extra: {
                                                              'id': BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.contractActive.first.id,
                                                              'price': package.price,
                                                              'payment_type': PaymentType.subscribeInPackage,
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                              color: AppColors.orange,
                                                              borderRadius: BorderRadius.only(
                                                                bottomRight: Radius.circular(16),
                                                                // bottomLeft: Radius.circular(16),
                                                              ),
                                                            ),
                                                            height: 40,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 4.0),
                                                              child: Text(
                                                                AppLocalizations.of(context)!.pay,
                                                                style: AppTextStyle.interRegularBoldWhite,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        color: Colors.white,
                                                        width: 2,
                                                        height: 40,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    CoolAlert.show(
                                                        context: context,
                                                        type: CoolAlertType.warning,
                                                        backgroundColor: AppColors.orange,
                                                        title: '${AppLocalizations.of(context)!.warning}!',
                                                        text: AppLocalizations.of(context)!.areYouSureYouWantToCancelThisPackage,
                                                        confirmBtnText: AppLocalizations.of(context)!.yes,
                                                        confirmBtnColor: AppColors.orange,
                                                        onConfirmBtnTap: () {
                                                          BlocProvider.of<PackagesBloc>(context).add(
                                                            UnsubscribePackage(
                                                              UnsubscribePackageParameters(
                                                                packageId: activeContract.state.toLowerCase() == 'paid' ? activeContract.id : package.id,
                                                                isPackagePaid: activeContract.state.toLowerCase() == 'paid',
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        showCancelBtn: true,
                                                        cancelBtnText: AppLocalizations.of(context)!.no,
                                                        onCancelBtnTap: () {},
                                                        cancelBtnTextStyle: AppTextStyle.interSmallBoldOrange,
                                                        confirmBtnTextStyle: AppTextStyle.interSmallBoldWhite);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: activeContract.state == 'Pending'
                                                          ? AppColors.lightGrey
                                                          : AppColors.orange,
                                                      borderRadius: const BorderRadius.only(
                                                        bottomLeft: Radius.circular(16),
                                                      ),
                                                    ),
                                                    height: 40,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 4.0),
                                                      child: Text(
                                                        AppLocalizations.of(context)!.unsubscribe,
                                                        style: activeContract.state == 'Pending'
                                                            ? AppTextStyle.interRegularBoldOrange : AppTextStyle.interRegularBoldWhite,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<PackagesBloc>(context).add(
                                            SubscribePackage(SubscribePackageParameters(packageId: package.id)),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.orange,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                          ),
                                          height: 40,
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              AppLocalizations.of(context)!.subscribe,
                                              style: AppTextStyle.interRegularBoldWhite,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }(),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              if (state is GetMaintenancePackagesFailed) {
                return Text(
                  AppLocalizations.of(context)!.error,
                  style: AppTextStyle.interRegularBlack,
                  textAlign: TextAlign.center,
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
