import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gulf_sky_provider/core/api/urls.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/core/utils/dio_utils.dart';
import 'package:gulf_sky_provider/features/data/models/client/notification_model.dart';
import 'package:gulf_sky_provider/features/data/models/client/rent_contract_info_model.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_notifications_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';
import '../../domain/usecases/client/pay_for_package_subscription_usecase.dart';

abstract class ClientDataSource {
  Future<Either<Failure, RentContractInfoModel>> getRentAndContractInfo();

  Future<Either<Failure, List<NotificationModel>>> getNotifications(GetNotificationsParameters parameters);

  Future<Either<Failure, String>> getClientSecretStripe();

  Future<Either<Failure, void>> payForOrder(PayForOrderParameters parameters);

  Future<Either<Failure, void>> payForPackageSubscription(PayForPackageSubscriptionParameters parameters);
}

class ClientDataSourceImpl extends ClientDataSource {
  final ApiService _apiService;

  ClientDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, RentContractInfoModel>> getRentAndContractInfo() async {
    ApiResult result = await _apiService.get(
        endPoint: URLs.getContractAndRentInfo,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(accept: true, contentType: true, withToken: true));
    try {
      if (result.type == ApiResultType.success) {
        return right(RentContractInfoModel.fromMap(result.data));
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getClientSecretStripe() async {
    ApiResult result = await _apiService.get(
        endPoint: URLs.getClientSecretStripe,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(accept: true, contentType: true, withToken: true));
    try {
      if (result.type == ApiResultType.success) {
        return right(result.data['client_secret']);
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> payForOrder(PayForOrderParameters parameters) async {
    PaymentMethod paymentMethod = await _getPaymentMethod(
      expireDate: parameters.expireDate,
      cvv: parameters.cvv,
      cardNumber: parameters.cardNumber,
      paymentSecret: parameters.cardNumber,
    );
    ApiResult result = await _apiService.post(
        endPoint: URLs.payForOrder,
        data: FormData.fromMap({
          'card': paymentMethod.id,
          'order_id': parameters.orderId,
        }),
        options: DioUtils.getOptions(accept: true, contentType: true, withToken: true));
    try {
      if (result.type == ApiResultType.success) {
        return right(null);
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> payForPackageSubscription(PayForPackageSubscriptionParameters parameters) async {
    PaymentMethod paymentMethod = await _getPaymentMethod(
      expireDate: parameters.expireDate,
      cvv: parameters.cvv,
      cardNumber: parameters.cardNumber,
      paymentSecret: parameters.cardNumber,
    );
    ApiResult result = await _apiService.post(
        endPoint: URLs.payForPackageSubscription,
        data: FormData.fromMap({
          'card': paymentMethod.id,
          'contract_id': parameters.packageId,
        }),
        options: DioUtils.getOptions(accept: true, contentType: true, withToken: true));
    try {
      if (result.type == ApiResultType.success) {
        return right(null);
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<PaymentMethod> _getPaymentMethod({
    required String paymentSecret,
    required String cvv,
    required String expireDate,
    required String cardNumber,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Gulf sky', style: ThemeMode.light, setupIntentClientSecret: paymentSecret),
    );

    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
        cvc: cvv,
        expirationMonth: int.parse(expireDate.substring(0, 2)),
        expirationYear: int.parse(expireDate.substring(3)),
        number: cardNumber));
    PaymentMethod paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
              name: '',
              address: Address(
                city: '',
                country: 'US',
                state: '',
                line1: '',
                line2: '',
                postalCode: '1111',
              ),
              phone: '',
              email: ''),
        ),
      ),
    );
    return paymentMethod;
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications(GetNotificationsParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getNotifications,
        data: FormData.fromMap({
          'page': parameters.page,
        }),
        options: DioUtils.getOptions(accept: true, contentType: true, withToken: true));
    try {
      if (result.type == ApiResultType.success) {
        return right((result.data['data'] as List)
            .map(
              (notificationModel) => NotificationModel.fromMap(notificationModel),
        )
            .toList());
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
