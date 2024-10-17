import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wonk_app/application/router/router.gr.dart';
import 'package:wonk_app/application/signals/theme_mode.dart';
import 'package:wonk_app/application/signals/user_signal.dart';
import 'package:wonk_app/domain/services/auth_service.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = userSignal.value!;
    final theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: theme.textTheme.h3,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeMode.value == ThemeMode.light ? PhosphorIconsRegular.moon : PhosphorIconsRegular.sun),
            onPressed: () {
              if (themeMode.value == ThemeMode.light) {
                themeMode.set(ThemeMode.dark);
              } else {
                themeMode.set(ThemeMode.light);
              }
            },
          ),
          IconButton(
            icon: const Icon(PhosphorIconsRegular.signOut),
            onPressed: () async {
              await GetIt.I<AuthService>().logout();
              context.navigateTo(const LoginRoute());
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ShadAvatar(
              user.photoUrl,
              size: const Size(100, 100),
            ),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: theme.textTheme.h4,
            ),
            Text(
              user.email,
              style: theme.textTheme.muted,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
