import 'package:flutter/material.dart';
import 'package:partners_app/models/partner.dart';
import 'package:partners_app/pages/edit_profile_page.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Widget _customText(String text, Widget icon) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 30),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  void _goToEditProfilePage(BuildContext context, Partner partner) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfilePage(
                partner: partner,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<PartnersProivders>(
          builder: (context, partnersProvider, child) {
        partnersProvider.getCurrentPartner();
        return Padding(
            padding: const EdgeInsets.fromLTRB(46.0, 10, 46.0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person,
                    size: 100, color: Theme.of(context).primaryColor),
                const SizedBox(height: 50),
                _customText(
                    '${partnersProvider.currentPartner?.businessName}',
                    Icon(
                      Icons.business,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 30),
                _customText(
                    '${partnersProvider.currentPartner?.email}',
                    Icon(
                      Icons.email,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 30),
                _customText(
                    '${partnersProvider.currentPartner?.phoneNumber}',
                    Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 30),
                _customText(
                    '${partnersProvider.currentPartner?.address}',
                    Icon(
                      Icons.location_pin,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 30),
                _customText(
                    '${partnersProvider.currentPartner?.reach}',
                    Icon(
                      Icons.groups_3,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 30),
                _customText(
                    '${partnersProvider.currentPartner?.contactPerson}',
                    Icon(
                      Icons.person_3,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                const SizedBox(height: 60),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      _goToEditProfilePage(
                          context,
                          partnersProvider.currentPartner ??
                              Partner(
                                id: 0,
                                businessName: '',
                                email: '',
                                phoneNumber: '',
                                address: '',
                                reach: 0,
                                contactPerson: '',
                              ));
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
