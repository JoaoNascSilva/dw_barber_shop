import 'package:dw_barber_shop/src/core/ui/constants.dart';
import 'package:dw_barber_shop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barber_shop/src/core/ui/helpers/messages.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_state.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          context.messageError(title: 'Acesso', message: errorMessage);
        case LoginState(status: LoginStateStatus.error):
          context.messageError(
              title: 'Acesso', message: 'Erro ao realizar login.');
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home/adm',
            (route) => false,
          );
          break;

        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home/employee',
            (route) => false,
          );
          break;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.backgroundChair),
              opacity: 0.4,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageLogo,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: emailEC,
                            onTapOutside: (_) => context.unFocus(),
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required('Email Obrigatótio.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordEC,
                            onTapOutside: (_) => context.unFocus(),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: 'Senha',
                              hintStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha Obrigatótia.'),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: ColorsConstants.brown),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () async {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  //Mostrar uma mensagem de erro com os campos inválidos
                                  context.messageSuccess(
                                    title: 'Acesso',
                                    message: 'Campos inválidos.',
                                  );
                                  break;

                                case true:
                                  await login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: const Text('ACESSAR'),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ), //Ocupa a tela como um todo
              ],
            ),
          ),
        ),
      ),
    );
  }
}
