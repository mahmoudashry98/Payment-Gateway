class Item {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  Item({required this.name, required this.quantity, required this.price, required this.currency});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      currency: json['currency'],
    );
  }
}

class Items {
  final List<Item> items;

  Items({required this.items});

  factory Items.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemList = json['items'];
    List<Item> parsedItems = itemList.map((itemJson) => Item.fromJson(itemJson)).toList();
    return Items(items: parsedItems);
  }
}