import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/presentation/pages/create_or_edit_reading/readings_type/area_type.dart';
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
      iconColor: AppColors.red02,
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
        final textColor = state.currentTheme == ThemeMode.light
            ? AppColors.darkBlue2A
            : AppColors.whiteFF;
        return Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => context.router.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textColor,
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: bgrColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.new_record_app_bar_title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 25,
                      color: textColor,
                    ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 20),
                  child: Text(
                    '25.01.25',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: textColor,
                        ),
                  ),
                ),
              ],
            ),
            _buildServicesList(),
            const SizedBox(height: 10),
            _buildTypeAndUnitPicker(),
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
          buildAreaType(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

_buildServicesList() {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: serviceList.length + 1,
          itemBuilder: (context, index) {
            final serviceIndex = index - 1;
            if (index == 0) {
              return _buildServiceItem(
                  onTapAction: () =>
                      context.router.pushNamed('/servicesScreen'));
            } else {
              return _buildServiceItem(
                index: serviceIndex,
                onTapAction: () {
                  print(serviceIndex);
                },
              );
            }
          },
        ),
      );
  }

_buildServiceItem({int? index, required Function() onTapAction}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) {
      final bgrColor = state.currentTheme == ThemeMode.light
          ? AppColors.whiteFF
          : AppColors.darkBlue2A;
      return GestureDetector(
          onTap: () => onTapAction(),
          child: Container(
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
                      color: index == null
                          ? AppColors.blueE
                          : serviceList[index].iconColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: index == null
                        ? const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.whiteFF)
                        : Image(image: AssetImage(serviceList[index].img)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                index == null
                    ? AppLocalizations.of(context)!.add_service_button_inscription
                    : serviceList[index].name,
                style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
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
                          const BorderSide(color: AppColors.blueE, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.blueE, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.blueE, width: 1),
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
