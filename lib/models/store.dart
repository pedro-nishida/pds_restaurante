class Store {
  int? storeId;
  String? storeName;
  String? storeAddress;
  double? storeLatitude;
  double? storeLongitude;
  String? storePhone;
  String? storeEmail;
  String? storePassword;

  Store({this.storeId, this.storeName, this.storeAddress, this.storeLatitude, this.storeLongitude, this.storePhone, this.storeEmail, this.storePassword})

  Store.fromJson(Map<String, dynamic> json){
    storeId = json['storeId'];
    storeName = json['storeName'];
    storeAddress = json['storeAddress'];
    storeLatitude = json['storeLatitude'];
    storeLongitude = json['storeLongitude'];
    storePhone = json['storePhone'];
    storeEmail = json['storeEmail'];
    storePassword = json['storePassword'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['storeAddress'] = this.storeAddress;
    data['storeLatitude'] = this.storeLatitude;
    data['storeLongitude'] = this.storeLongitude;
    data['storePhone'] = this.storePhone;
    data['storeEmail'] = this.storeEmail;
    data['storePassword'] = this.storePassword;
  }
}