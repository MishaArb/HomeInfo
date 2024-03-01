import 'package:flutter/material.dart';
import 'package:home_info/core/constants/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings_app_bar_title),
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
        _buildSettingsSectionTitle(
            title: AppLocalizations.of(context)!.general_screen_title,
            context: context),
        _buildSettingsItem(
          context: context,
          icon: Icons.notifications_active_outlined,
          iconColor: AppColors.orange1E,
          title: AppLocalizations.of(context)!.reminders_app_bar_title,
          onTapAction: () => context.router.pushNamed('/remindersScreen'),
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.dark_mode_outlined,
          iconColor: AppColors.blueF6,
          title: AppLocalizations.of(context)!.theme_app_bar_title,
          onTapAction: () => context.router.pushNamed('/themeScreen'),
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.language,
          iconColor: AppColors.brown31,
          title: AppLocalizations.of(context)!.language_app_bar_title,
          onTapAction: () => context.router.pushNamed('/languageScreen'),
        ),
        _buildSettingsSectionTitle(
            title: AppLocalizations.of(context)!.backup_screen_title,
            context: context
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.file_upload_outlined,
          iconColor: AppColors.purple7D,
          title: AppLocalizations.of(context)!.export_button_inscription,
          onTapAction: () {},
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.file_download_outlined,
          iconColor: AppColors.pinkAF,
          title: AppLocalizations.of(context)!.import_button_inscription,
          onTapAction: () {},
        ),
        _buildSettingsSectionTitle(
           title: AppLocalizations.of(context)!.about_us_screen_title,
            context: context
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.share,
          iconColor: AppColors.green07,
          title: AppLocalizations.of(context)!.share_button_inscription,
          onTapAction: () {
            print('Поділитись');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.star_border,
          iconColor: AppColors.yellow46,
          title: AppLocalizations.of(context)!.rate_us_button_inscription,
          onTapAction: () {
            print('Оцініть нас');
          },
        ),
        _buildSettingsItem(
          context: context,
          icon: Icons.email_outlined,
          iconColor: AppColors.blueD7,
          title: AppLocalizations.of(context)!.feedback_button_inscription,
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

_buildSettingsItem({
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
      color: AppColors.grey82,
    ),
  );
}

_buildAppVersion({
  required BuildContext context,
  required String version,
}) {
  return Center(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "${AppLocalizations.of(context)!.app_version_screen_inscription}: $version",
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        )),
  );
}
