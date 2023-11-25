import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gulf_sky_provider/core/api/urls.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/core/utils/dio_utils.dart';
import 'package:gulf_sky_provider/features/data/models/add_request/maintenance/add_maintenance_response_model.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';
import '../../domain/usecases/request/add_maintenance_request_usecase.dart';

abstract class AddRequestDataSource {
  Future<Either<Failure, AddMaintenanceResponseModel>> addMaintenanceRequest(
      AddMaintenanceRequestParameters parameters);

  Future<Either<Failure, void>> addEvacuationRequest(
      AddEvacuationRequestParameters parameters);
}

class AddRequestDataSourceImpl extends AddRequestDataSource {
  final ApiService _apiService;

  AddRequestDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, AddMaintenanceResponseModel>> addMaintenanceRequest(
      AddMaintenanceRequestParameters parameters) async {
    //Change images to Multipart files
    List<MultipartFile> imagesMultiParts = [];
    await Future.wait(parameters.images.map((image) async {
      MultipartFile imageMultipart = await MultipartFile.fromFile(
        image.path,
      );
      imagesMultiParts.add(imageMultipart);
    }));

    Map<String, MultipartFile> imagesMap = {};

    for (int index = 0; index < imagesMultiParts.length; index++) {
      imagesMap.putIfAbsent('images[${index+1}]', () => imagesMultiParts[index]);
    }

    Map<String, int> itemsMap = {};
    for (Map<String, int> material in parameters.items??[]) {
      itemsMap.putIfAbsent('items[${material['id']}]',()=> material['quantity']!,);
    }
    ApiResult result = await _apiService.post(
        endPoint: URLs.addMaintenanceRequest,
        data: FormData.fromMap(
          {
            'cause': parameters.cause,
            'address': parameters.address,
            'visit_date': DateFormat('yyyy-MM-dd HH:mm').format(parameters.visitDate),
            'lat': parameters.lat,
            'lng': parameters.lng,
            'rent_id': parameters.rentId,
            'contract_id': parameters.contractId,
            'service_id': parameters.serviceId,
            'service_section_id': parameters.serviceSectionId,
            'is_old': parameters.isOld ? 1 : 0,
          }..addAll(imagesMap)..addAll(itemsMap.isEmpty ? {'items[]':0} : itemsMap),
        ),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
          withToken: true,
          contentTypeString: 'multipart/form-data',
        ));
    try{
      if (result.type == ApiResultType.success) {
        return right(AddMaintenanceResponseModel.fromMap(result.data));
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e){
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addEvacuationRequest(AddEvacuationRequestParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.addEvacuationRequest,
        data: FormData.fromMap(
          {
            'cause': parameters.cause,
            'date': DateFormat('yyyy-MM-dd HH:mm').format(parameters.visitDate),
            'rent_id': parameters.rentId,
          },
        ),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
          withToken: true,
          contentTypeString: 'multipart/form-data',
        ));
    try{
      if (result.type == ApiResultType.success) {
        return right(null);
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e){
      return left(Failure(message: e.toString()));
    }
  }
}
