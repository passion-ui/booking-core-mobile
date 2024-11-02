import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  ///On Setting
  void _onSetting() {
    context.go(Routers.settings);
  }

  /// Login
  void _onLogin() {
    context.go(Routers.login);
  }

  /// Logout
  void _onLogout() {
    final authentication = context.read<AuthenticationBloc>();
    authentication.add(AuthenticationLoggedOut());
  }

  /// Build Authentication
  Widget _buildQuest() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Box(
              child: Column(
                children: [
                  Image.asset(
                    Images.waiting,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    Translate.of(context).translate(
                      'sign_in_to_continue_explore',
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _onLogin,
                          child: Text(
                            Translate.of(context).translate('login'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.cyan,
                      ),
                    ),
                    title: Translate.of(context).translate('settings'),
                    onPress: _onSetting,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    title: Translate.of(context).translate('rate_app'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                    title:
                        Translate.of(context).translate('share_with_friends'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.feedback_outlined,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    title: Translate.of(context).translate('help_feedback'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.policy_outlined,
                        color: Colors.green,
                      ),
                    ),
                    title: Translate.of(context).translate('terms_of_service'),
                    onPress: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Build For User
  Widget _buildForUser(UserEntity user) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: ImageCached(
                      width: 56,
                      height: 56,
                      url: user.avatar,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    title: user.displayName,
                    description: user.email,
                    onPress: _onSetting,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                    title: Translate.of(context).translate('booking_history'),
                    onPress: _onSetting,
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    title: Translate.of(context).translate('edit_profile'),
                    onPress: _onSetting,
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    title: Translate.of(context).translate('change_password'),
                    onPress: _onSetting,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.cyan,
                      ),
                    ),
                    title: Translate.of(context).translate('settings'),
                    onPress: _onSetting,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    title: Translate.of(context).translate('rate_app'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                    title:
                        Translate.of(context).translate('share_with_friends'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.feedback_outlined,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    title: Translate.of(context).translate('help_feedback'),
                    onPress: () {},
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.policy_outlined,
                        color: Colors.green,
                      ),
                    ),
                    title: Translate.of(context).translate('terms_of_service'),
                    onPress: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                    ),
                    title: Translate.of(context).translate('logout'),
                    onPress: _onLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authentication) {
        List<Widget>? actions;
        Widget container = SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        if (authentication is AuthenticationSuccess) {
          container = _buildForUser(authentication.user);
          actions = [
            Stack(
              children: [
                IconButton(
                  icon: Badge.count(
                    count: 9,
                    child: const Icon(Icons.notifications_none_outlined),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ];
        }
        if (authentication is AuthenticationFail) {
          container = _buildQuest();
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text(
                  Translate.of(context).translate('account'),
                ),
                pinned: true,
                actions: actions,
              ),
              container,
            ],
          ),
        );
      },
    );
  }
}
