import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  final String id;
  final String name;
  final String description;
  final String photo;
  final String cover;
  final List followers;
  final List mods;
  final List bolcked;
  final DocumentReference<Map<String, dynamic>> owner;
  final String type;
  final Shelter? shelter;

  Community(
    this.id,
    this.name,
    this.description,
    this.photo,
    this.cover,
    this.followers,
    this.mods,
    this.bolcked,
    this.owner,
    this.type, {
    this.shelter,
  });
}

class Shelter {
  final String form;
  final String leagalAddress;
  final String address;
  final String tin;
  final String checkpoint;
  final String bank;
  final String supervisor;
  final String email;
  final String website;
  final String authorized;
  final String donations;
  final String fullName;
  final String phone;

  Shelter(
    this.form,
    this.leagalAddress,
    this.address,
    this.tin,
    this.checkpoint,
    this.bank,
    this.supervisor,
    this.email,
    this.website,
    this.authorized,
    this.donations,
    this.fullName,
    this.phone,
  );
}
