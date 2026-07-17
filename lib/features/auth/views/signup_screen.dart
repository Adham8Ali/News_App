import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/core/widgets/custom_textfield.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_states.dart';
import 'package:news_app/features/auth/views/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _onSignUpPressed() {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty ||
        name.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showError('Please fill all fields');
      return;
    }

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    context.read<AuthCubit>().signUp(email, password, name);
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
        if (state is AuthSignUpSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                'Sign up',
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
              final contentWidth = isWide ? 560.0 : constraints.maxWidth;

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
                            'welcome to news pulse',
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
                            hintText: 'name',
                            prefixIcon: Icons.person,
                            controller: _nameController,
                          ),
                          SizedBox(height: spacing),
                          CustomTextField(
                            hintText: 'Password',
                            prefixIcon: Icons.lock,
                            controller: _passwordController,
                            isPassword: true,
                          ),
                          CustomTextField(
                            hintText: 'Confirm Password',
                            prefixIcon: Icons.lock,
                            controller: _confirmPasswordController,
                            isPassword: true,
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
                              onPressed: isLoading ? null : _onSignUpPressed,
                              child:
                                  isLoading
                                      ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              theme.colorScheme.onPrimary,
                                            ),
                                      )
                                      : Text(
                                        'sign up',
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
                                "Already have an account? ",
                                style: theme.textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
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
