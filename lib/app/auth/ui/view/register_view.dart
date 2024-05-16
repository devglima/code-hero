import 'package:codehero/app/auth/ui/cubit/password_visibility_cubit.dart';
import 'package:codehero/app/auth/ui/cubit/register_cubit.dart';
import 'package:codehero/app/auth/ui/widgets/block_button_widget.dart';
import 'package:codehero/utils/button_style.dart';
import 'package:codehero/utils/error_snack_bar.dart';
import 'package:codehero/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:codehero/config/app_config.dart' as config;

class RegisterBlocFirebaseWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBlocFirebaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterCubit registerCubit = Modular.get<RegisterCubit>();
    final PasswordVisibilityCubit passwordCubit =
        Modular.get<PasswordVisibilityCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: registerCubit,
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showSnackBarError(
            context,
            "Successfully registered!",
            SnackBarColors.success,
            marginBottom: 100,
          );
          Modular.to.navigate("/auth/login");
        } else if (state is RegisterError) {
          showSnackBarError(
            context,
            state.error,
            SnackBarColors.error,
            marginBottom: 100,
          );
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is RegisterLoading,
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
                      height: config.App(context).appHeight(29.5),
                      decoration: const BoxDecoration(color: Colors.red),
                    ),
                  ),
                  Positioned(
                    top: config.App(context).appHeight(24.5) - 105,
                    child: SizedBox(
                      width: config.App(context).appWidth(84),
                      height: config.App(context).appHeight(29.5),
                      child: Text(
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .merge(const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: config.App(context).appHeight(29.5) - 50,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 50,
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
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
                              keyboardType: TextInputType.text,
                              controller: _nameController,
                              validator: (input) => input!.length < 3
                                  ? "More than 3 characters"
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Full name",
                                labelStyle: const TextStyle(color: Colors.red),
                                contentPadding: const EdgeInsets.all(12),
                                hintText: 'João Silva',
                                hintStyle: const TextStyle(color: Colors.red),
                                prefixIcon: const Icon(Icons.account_box,
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
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (input) => !input!.contains('@')
                                  ? "Should be an valid email"
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: const TextStyle(color: Colors.red),
                                contentPadding: const EdgeInsets.all(12),
                                hintText: 'seuemail@email.com',
                                hintStyle: const TextStyle(color: Colors.red),
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
                              bloc: passwordCubit,
                              builder: (context, state) {
                                return TextFormField(
                                  obscureText: state.isVisible,
                                  controller: _passwordController,
                                  validator: (input) =>
                                      validatePassword(input!),
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle:
                                        const TextStyle(color: Colors.red),
                                    contentPadding: const EdgeInsets.all(12),
                                    hintText: '••••••••••••',
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.7)),
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: Colors.red),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        passwordCubit.toggleVisibility();
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
                              },
                            ),
                            const SizedBox(height: 25),
                            BlockButtonWidget(
                              loading: state is RegisterLoading,
                              text: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  registerCubit.register(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    child: TextButton(
                      onPressed: () {
                        Modular.to.navigate("/auth/login");
                      },
                      style: buttonStyleStadium(context),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child: Text(
                          "Back to login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
