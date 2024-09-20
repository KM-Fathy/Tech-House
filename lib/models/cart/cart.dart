class Cart {
  String description;
  String image;
  int price;
  String docId;
  int quantity;

  Cart({
    required this.description,
    required this.image,
    required this.price,
    required this.docId,
    this.quantity = 1,
  });
}
