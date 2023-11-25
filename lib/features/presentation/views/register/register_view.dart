import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/core/utils/assets_data.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/register_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/auth/auth_event.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/dialog_helper.dart';
import '../../../../core/utils/field_validator/field_validator.dart';
import '../../../../core/utils/show_toast.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../shared_widgets/custom_rounded_button.dart';
import '../../shared_widgets/text_fields/labeled_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ValueNotifier<XFile?> image = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: BlocListener<AuthBloc, AuthState>(
              bloc: BlocProvider.of<AuthBloc>(context),
              listener: (context, state) {
                if (state is RegisterLoading) {
                  EasyLoading.show(status: AppLocalizations.of(context)!.loading);
                } else if (state is RegisterFailed) {
                  EasyLoading.dismiss();
                  ToastUtils.showToast(state.errorMsg);
                } else if (state is RegisterSucceeded) {
                  EasyLoading.showSuccess(AppLocalizations.of(context)!.success, duration: const Duration(seconds: 1));
                  GoRouter.of(context).pushReplacement(AppRoutes.mainView);
                }
              },
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: AppTextStyle.interLargeBoldBlack,
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: image,
                    builder: (context, val, child) {
                      return GestureDetector(
                        onTap: () {
                          DialogHelper.showImagePickerDialog(
                            context: context,
                            onSelectImage: (img) => image.value = img,
                            onRemoveImage: () => image.value = null,
                          );
                        },
                        child: image.value != null
                            ? CircleAvatar(
                                radius: 65,
                                backgroundImage: FileImage(File(image.value!.path)),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(AssetsData.profile),
                                radius: 65,
                              ),
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.name}: ',
                        isRequired: true,
                        fieldLabel: '',
                        fieldValidator: FieldValidator.notEmpty,
                        textEditingController: nameController,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.username}: ',
                        isRequired: true,
                        fieldLabel: '',
                        fieldValidator: FieldValidator.notEmpty,
                        textEditingController: usernameController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.email}: ',
                        isRequired: true,
                        fieldLabel: '',
                        fieldValidator: FieldValidator.email,
                        textEditingController: emailController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.password}: ',
                        isRequired: true,
                        fieldLabel: '',
                        maxLines: 1,
                        fieldValidator: FieldValidator.password,
                        textEditingController: passwordController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.phone}: ',
                        isRequired: true,
                        fieldLabel: '',
                        maxLines: 1,
                        fieldValidator: FieldValidator.onlyDigits,
                        textEditingController: phoneController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.mobile}: ',
                        isRequired: true,
                        fieldLabel: '',
                        maxLines: 1,
                        fieldValidator: FieldValidator.onlyDigits,
                        textEditingController: mobileController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      LabeledTextField(
                        label: '${AppLocalizations.of(context)!.address}: ',
                        isRequired: true,
                        fieldLabel: '',
                        maxLines: 1,
                        fieldValidator: FieldValidator.none,
                        textEditingController: addressController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomRoundedButton(
                        label: AppLocalizations.of(context)!.register,
                        onPressed: () {
                          if (!FieldValidator.notEmpty.isValid(nameController.text) ||
                              !FieldValidator.notEmpty.isValid(usernameController.text) ||
                              !FieldValidator.email.isValid(emailController.text) ||
                              !FieldValidator.password.isValid(passwordController.text) ||
                              !FieldValidator.onlyDigits.isValid(phoneController.text) ||
                              !FieldValidator.onlyDigits.isValid(mobileController.text)) {
                            ToastUtils.showToast(AppLocalizations.of(context)!.someFieldsNotValid);
                            return;
                          }
                          BlocProvider.of<AuthBloc>(context).add(
                            Register(
                              parameters: RegisterParameters(
                                name: nameController.text,
                                username: usernameController.text,
                                email: emailController.text,
                                address: addressController.text,
                                mobile: mobileController.text,
                                image: (image.value != null) ? File(image.value!.path) : null,
                                phone: phoneController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        },
                        color: AppColors.orange,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.alreadyHaveAnAccount,
                            style: AppTextStyle.interSmallBoldBlack,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushReplacement(AppRoutes.loginView);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signIn,
                              style: AppTextStyle.interUnderlinedSmallBoldOrange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
