class Products {
  int? id;
  String? productname;
  String? description;
  double? price;
  double? tax;
  String? size;
  int? quantity;

  Products(
      {this.id,
      this.productname,
      this.description,
      this.price,
      this.tax,
      this.size,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['productname'];
    description = json['description'];
    price = json['price'];
    tax = json['tax'];
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productname'] = this.productname;
    data['description'] = this.description;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    return data;
  }
}
