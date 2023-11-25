import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/config/routes/app_routes.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';
import 'package:gulf_sky_provider/core/utils/assets_data.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/info/info_event.dart';

import '../../../../core/utils/show_toast.dart';
import '../../../domain/usecases/info/get_buildings_by_type_usecase.dart';
import '../../blocs/info/info_bloc.dart';
import '../../blocs/info/info_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<InfoBloc>(context).add(const GetBuildingsTypes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<InfoBloc, InfoState>(
          listener: (context, state) {
            if (state is GetBuildingsTypesFailed) {
              ToastUtils.showToast(state.errorMsg);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text(
                      "Gulf sky",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    background: Image.asset(
                      AssetsData.logo,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRoutes.notificationsView);
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                ),
                if (state is GetBuildingsTypesLoading)
                  const SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          height: 150,
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orange,
                          ),
                        )
                      ],
                    ),
                  ),
                if (state is GetBuildingsTypesFailed)
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        const SizedBox(
                          height: 150,
                        ),
                        Text(
                          AppLocalizations.of(context)!.error,
                          style: AppTextStyle.interRegularBlack,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                if (state is GetBuildingsTypesSucceeded)
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<InfoBloc>(context).add(
                              GetBuildingsByType(
                                  parameters: BuildingsByTypeParameters(
                                typeId: state.buildingsTypes[index].id,
                              )),
                            );
                            GoRouter.of(context).push(AppRoutes.buildingsByTypeView);
                          },
                          child: Container(
                            height: 100,
                            width: 50,
                            decoration: const BoxDecoration(color: AppColors.lightGrey),
                            child: Center(
                              child: Text(
                                state.buildingsTypes[index].name,
                                style: AppTextStyle.interLargeBoldOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                      childCount: state.buildingsTypes.length,
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
