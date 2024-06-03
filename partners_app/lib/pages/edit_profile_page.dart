import 'package:flutter/material.dart';
import 'package:partners_app/custom/custom_text_field.dart';
import 'package:partners_app/models/partner.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.partner});

  final Partner partner;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reachController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _businessNameController.text = widget.partner.businessName;
    _emailController.text = widget.partner.email;
    _phoneController.text = widget.partner.phoneNumber;
    _addressController.text = widget.partner.address;
    _reachController.text = widget.partner.reach.toString();
    _contactPersonController.text = widget.partner.contactPerson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                    label: 'Business name',
                    hint: 'Business Name',
                    controller: _businessNameController,
                    isTextObscured: false,
                    icon: const Icon(Icons.business)),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Email',
                    hint: 'Email',
                    controller: _emailController,
                    isTextObscured: false,
                    icon: const Icon(Icons.email)),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Phone',
                    hint: 'Phone',
                    controller: _phoneController,
                    isTextObscured: false,
                    icon: const Icon(Icons.phone)),
                const SizedBox(height: 20),
                CustomTextField(
                    hint: 'Address',
                    label: 'Address',
                    controller: _addressController,
                    isTextObscured: false,
                    icon: const Icon(Icons.location_pin)),
                const SizedBox(height: 20),
                CustomTextField(
                    hint: 'Reach',
                    label: 'Reach',
                    controller: _reachController,
                    isTextObscured: false,
                    icon: const Icon(Icons.groups_3)),
                const SizedBox(height: 20),
                CustomTextField(
                    hint: 'Contact Person',
                    label: 'Contact Person',
                    controller: _contactPersonController,
                    isTextObscured: false,
                    icon: const Icon(Icons.person)),
                const SizedBox(height: 40),
              ],
            ),
            Consumer<PartnersProivders>(
                builder: (context, partnersProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  int reach = int.tryParse(_reachController.value.text) ?? 0;
                  partnersProvider
                      .updatePartner(Partner(
                        id: widget.partner.id,
                        businessName: _businessNameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        address: _addressController.text,
                        reach: reach,
                        contactPerson: _contactPersonController.text,
                      ))
                      .then((value) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated successfully'),
                              ),
                            ),
                            Navigator.of(context).pop()
                          });
                },
                child: const Text('Save'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
