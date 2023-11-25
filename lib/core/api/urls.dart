class URLs{
  static const baseUrl = 'https://skygulfapp.gulfsky-app.website/';
  static const login = 'api/client/login';
  static const register = 'api/client/register';
  static const changeFCMToken = 'api/client/change_fcm';
  static const getBuildingsTypes = 'api/info/get_type_build';
  static const getBuildingsByType = 'api/info/get_buildings';
  static const getMaintenancePackages = 'api/package/get_packages';
  static const getServicesTypes = 'api/info/get_services';
  static const getServiceSections = 'api/info/get_services_section';
  static const addMaintenanceRequest = 'api/order/add_order';
  static const addEvacuationRequest = 'api/order/evacuation';
  static const getMaterialsTypes = 'api/info/get_material_types';
  static const getMaterialsByType = 'api/info/get_materials';
  static const getPackages = 'api/package/get_packages';
  static const subscribePackage = 'api/package/subscripe_packege';
  static const unsubscribePackage = 'api/package/cancel_package_subsription';
  static const cancelContract = 'api/payment/cancle_subscribtion';
  static const getContractAndRentInfo = 'api/client/get_info_contract_rent';
  static const getClientSecretStripe = 'api/client/get_secret_stripe';
  static const payForOrder = 'api/payment/pay_one_time';
  static const payForPackageSubscription = 'api/payment/pay_subscribtion';
  static const getNotifications = 'api/client/get_events';
  static const getOrders = 'api/client/get_orders';
}