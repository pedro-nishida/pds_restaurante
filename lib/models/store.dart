class Store {
  int? storeId;
  String? storeName;
  String? storeAddress;
  double? storeLatitude;
  double? storeLongitude;
  String? storePhone;
  String? storeEmail;
  String? storePassword;

  Store({this.storeId, this.storeName, this.storeAddress, this.storeLatitude, this.storeLongitude, this.storePhone, this.storeEmail, this.storePassword});

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
    final Map<String, dynamic> data = <String, dynamic>{}; // More idiomatic way to create a map
    data['storeId'] = storeId; // 'this.' is not strictly necessary here
    data['storeName'] = storeName;
    data['storeAddress'] = storeAddress;
    data['storeLatitude'] = storeLatitude;
    data['storeLongitude'] = storeLongitude;
    data['storePhone'] = storePhone;
    data['storeEmail'] = storeEmail;
    data['storePassword'] = storePassword;
    return data; // Added return statement
  }
}