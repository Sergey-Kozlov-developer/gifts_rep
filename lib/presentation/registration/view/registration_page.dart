import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gifts_rep/extensions/theme_extension.dart';
import 'package:gifts_rep/presentation/registration/bloc/registration_bloc.dart';
import 'package:gifts_rep/presentation/theme/build_context.dart';
import 'package:gifts_rep/resources/app_colors.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const Scaffold(
        body: _RegistrationPageWidget(),
      ),
    );
  }
}

class _RegistrationPageWidget extends StatefulWidget {
  const _RegistrationPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RegistrationPageWidget> createState() =>
      _RegistrationPageWidgetState();
}

class _RegistrationPageWidgetState extends State<_RegistrationPageWidget> {
  // для перехода на след поле ввода
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Создать аккаунт", style: context.theme.h2),
                  ),
                  const SizedBox(height: 24),
                  _EmailTextField(
                    emailFocusNode: _emailFocusNode,
                    passwordFocusNode: _passwordFocusNode,
                  ),
                  const SizedBox(height: 16),
                  _AvatarWidget(),
                ],
              ),
            ),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
  })  : _emailFocusNode = emailFocusNode,
        _passwordFocusNode = passwordFocusNode,
        super(key: key);

  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      // через BlocSelector подписываемся на ошибку email
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (_, current) => current is RegistrationFieldsInfo,
        builder: (context, state) {
          final fieldsInfo = state as RegistrationFieldsInfo;
          final error = fieldsInfo.emailError;
          return TextField(
            focusNode: _emailFocusNode,
            onChanged: (text) => context
                .read<RegistrationBloc>()
                .add(RegistrationEmailChanged(text)),
            onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Почта',
              errorText: error?.toString(),
            ),
          );
        },
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(
        left: 8,
        top: 6,
        bottom: 6,
        right: 4,
      ),
      decoration: BoxDecoration(
        color: context.dynamicPlainColor(
          context: context,
          lightThemeColor: AppColors.lightLightBlue100,
          darkThemeColor: AppColors.darkWhite20,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          BlocBuilder<RegistrationBloc, RegistrationState>(
            buildWhen: (_, current) => current is RegistrationFieldsInfo,
            builder: (context, state) {
              final fieldsInfo = state as RegistrationFieldsInfo;
              return SvgPicture.network(
                fieldsInfo.avatarLink,
                height: 48,
                width: 48,
              );
            },
          ),
          const SizedBox(width: 8),
          Text("Ваш аватар", style: context.theme.h3),
          const Spacer(),
          TextButton(
            onPressed: () => context
                .read<RegistrationBloc>()
                .add(const RegistrationChangeAvatar()),
            child: Text("Изменить"),
          ),
        ],
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        //BlocSelector(имитирует получен состояние) состояние
        // дизаблим кнопку если одно из полей не валидно
        // если все верно заполнено, то осуществляем авторизацию
        child: BlocSelector<RegistrationBloc, RegistrationState, bool>(
          selector: (state) => state is RegistrationInProgress,
          builder: (context, inProgress) {
            return ElevatedButton(
              onPressed: inProgress
                  ? null
                  : () => context
                      .read<RegistrationBloc>()
                      .add(const RegistrationCreateAccount()),
              child: const Text("Создать"),
            );
          },
        ),
      ),
    );
  }
}
