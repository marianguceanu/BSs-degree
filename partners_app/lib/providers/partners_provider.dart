import 'package:flutter/material.dart';
import 'package:partners_app/models/partner.dart';
import 'package:partners_app/services/partner_service.dart';

class PartnersProivders extends ChangeNotifier {
  PartnersProivders({required this.partnersApiService});

  List<Partner> _partners = [];
  final PartnerApiService partnersApiService;

  List<Partner> get partners => _partners;

  Future<void> initPartners() async {
    _partners = await partnersApiService.getPartners();
    notifyListeners();
  }
}
