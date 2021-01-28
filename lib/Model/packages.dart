class Packages{
  String id;
  String title;
  String price;
  List<Items> item;

  Packages({
  this.id,
  this.price,
  this.title,
  this.item
  });
}

class Items{
  String title;
  String status;
  String packageTitle;

  Items({
  this.status,
  this.title,
  this.packageTitle
  });
}

