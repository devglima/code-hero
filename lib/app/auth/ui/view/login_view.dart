import 'package:codehero/app/auth/ui/cubit/auth_cubit.dart';
import 'package:codehero/app/auth/ui/cubit/password_visibility_cubit.dart';
import 'package:codehero/app/auth/ui/widgets/block_button_widget.dart';
import 'package:codehero/utils/button_style.dart';
import 'package:codehero/utils/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:codehero/config/app_config.dart' as config;

class LoginBlocFirebaseWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController(text: "");

  final TextEditingController _passwordController =
      TextEditingController(text: "");

  LoginBlocFirebaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = Modular.get<AuthCubit>();
    final PasswordVisibilityCubit passwordVisibilityCubit =
        Modular.get<PasswordVisibilityCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthSuccess) {
            showSnackBarError(
              context,
              "Welcome! ${state.user.user_name}",
              SnackBarColors.error,
              marginBottom: 100,
            );
            Modular.to.navigate('/home/');
          } else if (state is AuthError) {
            showSnackBarError(
              context,
              "Wrong user/password!",
              SnackBarColors.error,
              marginBottom: 100,
            );
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AuthLoading,
            child: PopScope(
              canPop: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: Container(
                        width: config.App(context).appWidth(100),
                        height: config.App(context).appHeight(37),
                        decoration: const BoxDecoration(color: Colors.red),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      child: Image.asset(
                        "assets/images/marvel_logo.png",
                        height: 60,
                      ),
                    ),
                    Positioned(
                      top: config.App(context).appHeight(37) - 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 50,
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.2),
                              )
                            ]),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 27),
                        width: config.App(context).appWidth(88),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                validator: (input) {
                                  return !input!.contains('@')
                                      ? "Should be a valid email"
                                      : null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                      const TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(12),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: const Icon(Icons.alternate_email,
                                      color: Colors.red),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                ),
                              ),
                              const SizedBox(height: 30),
                              BlocBuilder<PasswordVisibilityCubit,
                                      PasswordVisibilityState>(
                                  bloc: passwordVisibilityCubit,
                                  builder: (context, state) {
                                    return TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _passwordController,
                                      validator: (input) =>
                                          input != null && input.length < 3
                                              ? "Should be a valid password"
                                              : null,
                                      obscureText: state.isVisible,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle:
                                            const TextStyle(color: Colors.red),
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        hintText: '••••••••••••',
                                        hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.7)),
                                        prefixIcon: const Icon(
                                            Icons.lock_outline,
                                            color: Colors.red),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            passwordVisibilityCubit
                                                .toggleVisibility();
                                          },
                                          color: Theme.of(context).focusColor,
                                          icon: Icon(state.isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.2))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.5))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.2))),
                                      ),
                                    );
                                  }),
                              const SizedBox(height: 30),
                              BlockButtonWidget(
                                loading: state is AuthLoading,
                                text: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    authCubit.login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      child: Column(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Modular.to.navigate(
                                '/auth/register',
                              );
                            },
                            style: buttonStyleStadium(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
