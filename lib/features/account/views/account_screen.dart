import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/theme_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/core/navigation/app_routes.dart';
import 'package:news_app/core/navigation/navigation_helpers.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.currentUser;
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 24 : 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${user?.name ?? "User"} 👋",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isWide ? 28 : 24,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Welcome back",
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 17),
                  ),

                  SizedBox(height: isWide ? 28 : 24),

                  Card(
                    elevation: 3,
                    color: theme.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: theme.iconTheme.color,
                            ),
                            title: const Text("Name"),
                            subtitle: Text(user?.name ?? ""),
                          ),
                          Divider(color: theme.dividerColor),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: theme.iconTheme.color,
                            ),
                            title: const Text("Email"),
                            subtitle: Text(user?.email ?? ""),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isWide ? 24 : 20),

                  SwitchListTile(
                    value: context.watch<ThemeCubit>().isDark,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    secondary: Icon(
                      Icons.dark_mode,
                      color: theme.iconTheme.color,
                    ),
                    title: Text(
                      "Dark Mode",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
                      ),
                      onPressed: () async {
                        await authCubit.logout();
                        if (!context.mounted) return;

                        context.pushNamedAndRemoveUntil(
                          AppRoutes.login,
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: Text("Logout", style: theme.textTheme.titleMedium),
                    ),
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
