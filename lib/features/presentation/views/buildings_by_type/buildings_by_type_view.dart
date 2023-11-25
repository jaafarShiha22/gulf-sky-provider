import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';
import 'package:gulf_sky_provider/core/utils/assets_data.dart';

import '../../../../core/utils/show_toast.dart';
import '../../blocs/info/info_bloc.dart';
import '../../blocs/info/info_event.dart';
import '../../blocs/info/info_state.dart';

class BuildingsByTypeView extends StatefulWidget {
  const BuildingsByTypeView({Key? key}) : super(key: key);

  @override
  State<BuildingsByTypeView> createState() => _BuildingsByTypeViewState();
}

class _BuildingsByTypeViewState extends State<BuildingsByTypeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<InfoBloc>(context).add(const GetBuildingsTypes());
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<InfoBloc, InfoState>(
            listener: (context, state) {
              if (state is GetBuildingsByTypeFailed) {
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
                  ),
                  if (state is GetBuildingsByTypeLoading)
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
                          ),
                        ],
                      ),
                    ),
                  if (state is GetBuildingsByTypeFailed)
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
                  if (state is GetBuildingsByTypeSucceeded)
                    SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 50,
                            decoration: const BoxDecoration(color: AppColors.lightGrey),
                            child: Center(
                              child: Text(
                                state.buildingsByType[index].name,
                                style: AppTextStyle.interLargeBoldOrange,
                              ),
                            ),
                          ),
                        ),
                        childCount: state.buildingsByType.length,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
