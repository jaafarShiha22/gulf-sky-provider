import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/pay/pay_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/pay/pay_state.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/secret_stripe/secret_stripe_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/shared_widgets/custom_rounded_button.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/enums/payment_type.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../domain/usecases/client/pay_for_package_subscription_usecase.dart';
import '../../blocs/pay/pay_event.dart';

class PaymentView extends StatefulWidget {
  final int id;
  final num price;
  final PaymentType paymentType;

  const PaymentView({
    Key? key,
    required this.id,
    required this.price,
    required this.paymentType,
  }) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecretStripeCubit, SecretStripeState>(
      listener: (context, state) {
        if (state is SecretStipeLoading) {
          EasyLoading.show(status: AppLocalizations.of(context)!.loading);
        } else if (state is SecretStipeSucceeded) {
          switch (widget.paymentType) {
            case PaymentType.payForOrder:
              BlocProvider.of<PayBloc>(context).add(PayForOrder(
                PayForOrderParameters(
                    paymentSecret: state.clientSecretStripe,
                    cardNumber: cardNumber,
                    cvv: cvvCode,
                    orderId: widget.id,
                    expireDate: expiryDate),
              ));
              break;
            case PaymentType.subscribeInPackage:
              BlocProvider.of<PayBloc>(context).add(PayForPackageSubscription(
                PayForPackageSubscriptionParameters(
                    paymentSecret: state.clientSecretStripe,
                    cardNumber: cardNumber,
                    cvv: cvvCode,
                    packageId: widget.id,
                    expireDate: expiryDate),
              ));
              break;
            default:
              break;
          }
        } else if (state is SecretStipeFailed) {
          EasyLoading.dismiss();
          ToastUtils.showToast(state.errorMsg);
        }
      },
      child: BlocListener<PayBloc, PayState>(
        listener: (context, state) {
          if (state is PaySucceeded) {
            EasyLoading.showSuccess(AppLocalizations.of(context)!.success);
            GoRouter.of(context).pop();
            GoRouter.of(context).pop();
          } else if (state is PayFailed) {
            EasyLoading.dismiss();
            ToastUtils.showToast(state.errorMsg);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${AppLocalizations.of(context)!.youWillPay}\n ${widget.price} ${AppLocalizations.of(context)!.aed}',
                  style: AppTextStyle.interLargeBoldBlack,
                ),
                const SizedBox(
                  height: 16,
                ),
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: '',
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: false,
                  cardBgColor: AppColors.orange,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange: (creditCardBrand) {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: false,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: '',
                          expiryDate: expiryDate,
                          themeColor: AppColors.orange,
                          textColor: AppColors.orange,
                          cardNumberDecoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.number,
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: AppTextStyle.interSmallBlack,
                            labelStyle: AppTextStyle.interSmallBlack,
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: AppTextStyle.interSmallBlack,
                            labelStyle: AppTextStyle.interSmallBlack,
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: AppLocalizations.of(context)!.expiredDate,
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: AppTextStyle.interSmallBlack,
                            labelStyle: AppTextStyle.interSmallBlack,
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: AppLocalizations.of(context)!.cvv,
                            hintText: 'XXX',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRoundedButton(
                      label: AppLocalizations.of(context)!.pay,
                      color: AppColors.orange,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        BlocProvider.of<SecretStripeCubit>(context).getSecretStripe();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
