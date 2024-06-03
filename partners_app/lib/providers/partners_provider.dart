import 'package:flutter/material.dart';
import 'package:partners_app/models/partner.dart';
import 'package:partners_app/models/signup.dart';
import 'package:partners_app/services/partner_service.dart';

class PartnersProivders extends ChangeNotifier {
  PartnersProivders({required this.partnersApiService});

  List<Partner> _partners = [];
  List<Partner> _topFive = [];
  Partner? _currentPartner;
  final PartnerApiService partnersApiService;

  List<Partner> get partners => _partners;
  List<Partner> get topFive => _topFive;
  Partner? get currentPartner => _currentPartner;

  Future<void> initPartners() async {
    _partners = await partnersApiService.getPartners();
    notifyListeners();
  }

  Future<List<Partner>> getTopFive() async {
    _topFive = await partnersApiService.topFive();
    notifyListeners();
    return _topFive;
  }

  Future<int> signUp(SignUp signupBody) async {
    return await partnersApiService.signUp(signupBody);
  }

  Future<Partner?> getCurrentPartner() async {
    int partnerId = await partnersApiService.getPartnerId();
    _currentPartner = await partnersApiService.getPartnerById(partnerId);
    notifyListeners();
    return _currentPartner;
  }

  Future<int> updatePartner(Partner partner) async {
    return await partnersApiService.updatePartner(partner);
  }
}
