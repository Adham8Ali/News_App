import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/core/widgets/custom_textfield.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_states.dart';
import 'package:news_app/features/auth/views/signup_screen.dart';
import 'package:news_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:news_app/features/home/views/navbar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter email and password');
      return;
    }

    context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    final isWide = screenSize.width >= 600;
    final isLandscape = screenSize.width > screenSize.height;
    final buttonHeight = (screenSize.height * 0.07).clamp(48.0, 60.0);
    final spacing =
        isLandscape
            ? (screenSize.height * 0.016).clamp(10.0, 22.0)
            : (screenSize.height * 0.025).clamp(16.0, 28.0);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthloginSuccess) {
          context.read<FavoriteCubit>().getFavorites();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavBar()),
          );
        }

        if (state is AuthError) {
          _showError(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: CircleAvatar(
              backgroundColor: theme.cardColor,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: theme.iconTheme.color,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Login',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isWide ? 20 : 18,
                ),
              ),
            ),
            surfaceTintColor: theme.colorScheme.surface.withValues(alpha: 0.0),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final contentWidth = isWide ? 560.0 : maxWidth;

              return SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 0 : 12,
                        vertical: isLandscape ? 12 : 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'welcome back',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                              fontSize: isWide ? 28 : 24,
                            ),
                          ),
                          SizedBox(height: spacing),
                          CustomTextField(
                            hintText: 'Email',
                            prefixIcon: Icons.email,
                            controller: _emailController,
                          ),
                          SizedBox(height: spacing),
                          CustomTextField(
                            hintText: 'Password',
                            prefixIcon: Icons.lock,
                            controller: _passwordController,
                            isPassword: true,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: spacing),

                          SizedBox(
                            height: buttonHeight,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: isLoading ? null : _onLoginPressed,
                              child:
                                  isLoading
                                      ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              theme.colorScheme.onPrimary,
                                            ),
                                      )
                                      : Text(
                                        'Login',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  theme.colorScheme.onPrimary,
                                              fontSize: isWide ? 18 : 16,
                                            ),
                                      ),
                            ),
                          ),

                          SizedBox(height: spacing * 1.2),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: theme.dividerColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  "Or continue with",
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(color: theme.dividerColor),
                              ),
                            ],
                          ),

                          SizedBox(height: spacing),

                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 12,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: theme.colorScheme.primary,
                                  size: isWide ? 32 : 28,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: theme.colorScheme.error,
                                  size: isWide ? 32 : 28,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.xTwitter,
                                  color: theme.iconTheme.color,
                                  size: isWide ? 32 : 28,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),

                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: theme.textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const SignupScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
