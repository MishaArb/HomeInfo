import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/presentation/pages/create_or_edit_reading/readings_type/three_zone_meter_type.dart';
import '../../../core/constants/asset_image.dart';
import '../../../core/themes/app_colors.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../widgets/buttons/elevated_button.dart';



class ServiceReading{
  ServiceReading({required this.date, required this.img, required this.name, required this.iconColor});
  final String date;
  final Color iconColor;
  final String img;
  final String name;
}

const List<String> typeDropList = <String>[
  'Однозонний лічильник',
  'За площу',
  'Фіксовано',
  'Двозонний лічильник',
  'Тризонний лічильник'
];
const List<String> utilDropList = <String>['кВт', 'м2', 'м3', 'Гкал'];
String? dropdownValue = typeDropList.first;

List serviceList = [
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.orange1E,
      img: AssetImagesConstant.servicesImg[0],
      name: 'Електроенергія'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.blueE,
      img: AssetImagesConstant.servicesImg[1],
      name: 'Опалення'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.blueD7,
      img: AssetImagesConstant.servicesImg[2],
      name: 'Оренда'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.purple7D,
      img: AssetImagesConstant.servicesImg[3],
      name: 'Звязок'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.pinkAF,
      img: AssetImagesConstant.servicesImg[4],
      name: 'Вивіз сміття'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.yellow46,
      img: AssetImagesConstant.servicesImg[5],
      name: 'Вода'
    ),
  ServiceReading(
      date: '25.01.25',
      iconColor: AppColors.red01,
      img: AssetImagesConstant.servicesImg[6],
      name: 'Інтернет'
    ),
];

@RoutePage()
class CreateOrEditReadingsScreen extends StatelessWidget {
  const CreateOrEditReadingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const CreateOrEditReadingsScreenWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildSaveButton(context),
    );
  }
}

_buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(256),
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => context.router.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.whiteFF,
                ),
              ),
              backgroundColor: AppColors.blue8F,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.blue8F,
                systemNavigationBarColor: bgrColor,
                statusBarIconBrightness: Brightness.light,
              ),
              title: Text(
                AppLocalizations.of(context)!.new_record_app_bar_title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 25,
                      color: AppColors.whiteFF,
                    ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 20),
                  child: Text(
                    '25.01.25',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteFF,
                        ),
                  ),
                ),
              ],
            ),
            _buildServicesListAndTypePicker(context),
          ],
        );
      },
    ),
  );
}

class CreateOrEditReadingsScreenWidget extends StatelessWidget {
  const CreateOrEditReadingsScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildThreeZoneMeterType(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

_buildServicesListAndTypePicker(BuildContext context) {
  return SizedBox(
    height: 200,
    child: Stack(
      children: [
        Container(
          height: 140,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: <Color>[AppColors.blue8F, AppColors.blue8F],
            ),
          ),
        ),
        _buildServicesList(),
        _buildTypeAndUnitPicker(),
      ],
    ),
  );
}

_buildServicesList() {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) {
      final bgrColor = state.currentTheme == ThemeMode.light
          ? AppColors.whiteFF
          : AppColors.darkBlue2A;
    return SizedBox(
    height: 70,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: serviceList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bgrColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: serviceList[index].iconColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Image(
                  image: AssetImage(serviceList[index].img),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                serviceList[index].name,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      },
    ),
  );
  },
);
}

_buildTypeAndUnitPicker() {
  return Align(
    alignment: const Alignment(0, 0.8),
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        final shadow = state.currentTheme == ThemeMode.light
            ? AppColors.grey82.withOpacity(0.2)
            : AppColors.black00.withOpacity(0.2);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgrColor,
            boxShadow: [
              BoxShadow(
                color: shadow,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDropdownItem(
                context: context,
                inscription:
                    AppLocalizations.of(context)!.type_measurement_inscription.toUpperCase(),
                hintText: AppLocalizations.of(context)!
                    .choose_measurement_button_inscription,
                valueList: typeDropList,
              ),
              _buildDropdownItem(
                context: context,
                inscription:
                    AppLocalizations.of(context)!.units_measurement_inscription.toUpperCase(),
                hintText: AppLocalizations.of(context)!
                    .choose_unit_button_inscription,
                valueList: utilDropList,
              ),

            ],
          ),
        );
      },
    ),
  );
}

_buildDropdownItem(
    {required BuildContext context,
    required String inscription,
    required String hintText,
    required List<String> valueList}) {
  return Expanded(
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final bgrColor = state.currentTheme == ThemeMode.light
            ? AppColors.whiteFF
            : AppColors.darkBlue2A;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(inscription,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // width: 150,
              height: 40,
              child: Center(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  isDense: false,
                  itemHeight: 50,
                  style: Theme.of(context).textTheme.titleMedium,
                  hint: Text(
                    hintText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  dropdownColor: bgrColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.blue8F, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.blue8F, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.blue8F, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    dropdownValue = newValue!;
                  },
                  items: valueList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

_buildSaveButton(BuildContext context) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) {
      final bgrColor = state.currentTheme == ThemeMode.light
          ? AppColors.whiteFF
          : AppColors.darkBlue2A;
      final shadow = state.currentTheme == ThemeMode.light
          ? AppColors.greyD9
          : AppColors.black00.withOpacity(0.3);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bgrColor,
          boxShadow: [
            BoxShadow(
              color: shadow,
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 80,
        child: buildElevationButton(
          buttonText: AppLocalizations.of(context)!.save_button_inscription,
          buttonAction: () {
            print('Зберегти');
          },
        ),
      );
    },
  );
}
