part of 'home_screen.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, chartState) {
        return Expanded(
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final bgrColor = state.currentTheme == ThemeMode.light
                  ? AppColors.whiteFF
                  : AppColors.darkBlue2A;
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: AppProperty.allBorderRadiusLarge,
                  color: bgrColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildDropDown(chartState, context, bgrColor),
                    Expanded(
                      child: Row(
                        children: [
                          buildLeftTitlesSum(chartState, context),
                          buildChartColumn(chartState, context, size),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  buildDropDown(ChartState chartState, BuildContext context, Color bgrColor) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      width: 150,
      height: 40,
      child: DropdownButtonFormField(
        isExpanded: true,
        isDense: false,
        itemHeight: 60,
        value: DropDownValue.totalValue,
        style: Theme.of(context).textTheme.titleMedium,
        dropdownColor: bgrColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.greyD9, width: 1),
            borderRadius: AppProperty.allBorderRadiusMediumSmall,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.greyD9, width: 1),
            borderRadius: AppProperty.allBorderRadiusMediumSmall,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.greyD9, width: 1),
            borderRadius: AppProperty.allBorderRadiusMediumSmall,
          ),
        ),
        onChanged: (newValue) {
          BlocProvider.of<ChartBloc>(context)
              .add(ChartPickDropDownValueEvent(newValue!));
        },
        items: chartState.dropDownsItems.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value == DropDownValue.totalValue
                    ? AppLocalizations.of(context)!.total_dropdown
                    : value,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  buildLeftTitlesSum(ChartState chartState, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 55, bottom: 20),
      // color: Colors.blue,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${chartState.maxValue.round()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            '${(chartState.maxValue / 2).round()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            '0',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  buildChartColumn(
    ChartState chartState,
    BuildContext context,
    Size size,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(top: 55),
          width: size.width,
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, m) {
                      return Text(
                        chartState.chartColumn.keys.toList()[v.toInt()],
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    },
                  ),
                ),
              ),
              maxY: chartState.maxValue.roundToDouble(),
              minY: 0,
              barGroups: [
                for (var i = 0; i < chartState.chartColumn.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: chartState.chartColumn.values.toList()[i],
                        width: 35,
                        color: AppColors.yellow46,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
