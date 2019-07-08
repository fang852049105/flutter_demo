class CartInfoModel {
  //{"goodsId":"2171c20d77c340729d5d7ebc2039c08d","goodsName":"五粮液52°500ml","count":1,"price":830.0,"images":"http://images.baixingliangfan.cn/shopGoodsImg/20181229/20181229211422_8507.jpg"}
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.images, this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck']= this.isCheck;
    return data;
  }
}