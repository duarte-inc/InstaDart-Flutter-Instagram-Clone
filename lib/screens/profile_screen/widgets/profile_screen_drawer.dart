import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/models/models.dart';
import 'package:instagram/models/user_data.dart';
import 'package:instagram/screens/profile_screen/screens/deleted_posts_screen.dart';
import 'package:instagram/screens/screens.dart';
import 'package:instagram/utilities/constants.dart';
import 'package:instagram/utilities/themes.dart';
import 'package:instagram/widgets/user_badges.dart';
import 'package:provider/provider.dart';

class ProfileScreenDrawer extends StatelessWidget {
  final User user;
  ProfileScreenDrawer({@required this.user});

  _buildDrawerOption(Widget icon, String title, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 250,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 56,
                child: ListTile(
                    title: Row(
                  children: [
                    Text(
                      user.name,
                      style: kFontSize18TextStyle,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    UserBadges(user: user, size: 20),
                  ],
                )),
              ),
              Divider(height: 3),
              _buildDrawerOption(
                Icon(Icons.history),
                'Archive',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeletedPostsScreen(
                        currentUserId:
                            Provider.of<UserData>(context, listen: false)
                                .currentUserId,
                        postStatus: PostStatus.archivedPost),
                  ),
                ),
              ),
              _buildDrawerOption(
                Icon(Icons.delete),
                'Deleted Posts',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeletedPostsScreen(
                      currentUserId:
                          Provider.of<UserData>(context, listen: false)
                              .currentUserId,
                      postStatus: PostStatus.deletedPost,
                    ),
                  ),
                ),
              ),
              _buildDrawerOption(
                  Icon(Icons.history_toggle_off), 'Your Activity', null),
              if (user.role == 'admin')
                _buildDrawerOption(
                    FaIcon(
                      FontAwesomeIcons.userShield,
                    ),
                    'Admins Section',
                    null),
              _buildDrawerOption(Icon(Icons.bookmark), 'Saved', null),
              // _buildDrawerOption(
              //   Icon(Icons.bookmark),
              //   'Splash Screen test',
              //   () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (_) => SplashScreen(),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildDrawerOption(
                    Icon(Icons.settings),
                    'Settings',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsScreen(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
