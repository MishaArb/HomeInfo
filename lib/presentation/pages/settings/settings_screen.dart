import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Налаштування"),
      ),
      body: const SettingsScreenView(),
    );
  }
}

class SettingsScreenView extends StatelessWidget {
  const SettingsScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _SettingsItemsListWidget();
  }
}

class _SettingsItemsListWidget extends StatelessWidget {
  const _SettingsItemsListWidget();

  @override
  Widget build(BuildContext context) {
    return _buildSettingsItemList(context);
  }
}

_buildSettingsItemList(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSettingsSectionTitle(title: 'Загальні', context: context),
        _buildSettingsItem(
          context: context,
          icon: Icons.notifications_active_outlined,
          iconColor: AppColors.orange1E,
          title: 'Нагадування',
          onTapAction: () {
            print('Нагадування');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.dark_mode_outlined,
          iconColor: AppColors.blueF6,
          title: 'Тема',
          onTapAction: () {
            print('Тема');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.language,
          iconColor: AppColors.brown31,
          title: 'Мова',
          onTapAction: () {
            print('Мова');
          },
        ),
        _buildSettingsSectionTitle(title: 'Резервне копіювання', context: context),
        _buildSettingsItem(
          context: context,
          icon: Icons.file_upload_outlined,
          iconColor: AppColors.purple7D,
          title: 'Експорт',
          onTapAction: () {
            print('Експорт');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.file_download_outlined,
          iconColor: AppColors.pinkAF,
          title: 'Імпорт',
          onTapAction: () {
            print('Імпорт');
          },
        ),
        _buildSettingsSectionTitle(title: 'Про нас', context: context),
        _buildSettingsItem(
          context: context,
          icon: Icons.share,
          iconColor: AppColors.green07,
          title: 'Поділитись',
          onTapAction: () {
            print('Поділитись');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.star_border,
          iconColor: AppColors.yellow46,
          title: 'Оцініть нас',
          onTapAction: () {
            print('Оцініть нас');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.email_outlined,
          iconColor: AppColors.blueD7,
          title: 'Зворотній звязок',
          onTapAction: () {
            print('Зворотній звязок');
          },
        ),
        _buildAppVersion(context: context, version: '1.0.0')
      ],
    ),
  );
}

_buildSettingsSectionTitle({
  required String title,
  required BuildContext context
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );
}

ListTile _buildSettingsItem({
  required BuildContext context,
  required IconData icon,
  required Color iconColor,
  required String title,
  required void Function() onTapAction,
}) {
  return ListTile(
    onTap: onTapAction,
    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
    leading: Icon(icon, color: iconColor),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 20,
    ),
  );
}

Center _buildAppVersion({
  required BuildContext context,
  required String version,
}) {
  return Center(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "Версія додатку: $version",
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        )),
  );
}
