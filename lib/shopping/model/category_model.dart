class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto; //小类别列表
  String image;
  String comments;

  //构造函数
  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.image,
    this.comments
  });

 factory CategoryBigModel.fromJson(Map<String, dynamic> json) {
    return CategoryBigModel(
        mallCategoryId: json['mallCategoryId'],
        mallCategoryName: json['mallCategoryName'],
        comments: json['comments'],
        image: json['image'],
        bxMallSubDto: (json['bxMallSubDto'] as List).cast().map((i) =>
            BxMallSubDto.fromJson(i)).toList()
    );
  }

//  CategoryBigModel.fromJson(Map<String, dynamic> json) {
//    mallCategoryId = json['mallCategoryId'];
//    mallCategoryName = json['mallCategoryName'];
//    if (json['bxMallSubDto'] != null) {
//      bxMallSubDto = new List<BxMallSubDto>();
//      json['bxMallSubDto'].forEach((v) {
//        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
//      });
//    }
//    comments = json['comments'];
//    image = json['image'];
//  }
}


class CategoryBigListModel {

  List<CategoryBigModel> CategoryBigModelList;
  CategoryBigListModel(this.CategoryBigModelList);
  factory CategoryBigListModel.formJson(List json){
    return CategoryBigListModel(
        json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }

}

class BxMallSubDto{
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;
  //构造函数
  BxMallSubDto({
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments,
  });

  //工厂模式——用这种模式可以省略New关键字.factory 关键字的功能，当实现构造函数但是不想每次都创建该类的一个实例的时候使用。
  factory BxMallSubDto.fromJson(Map<String, dynamic> json) {
    return BxMallSubDto(
        mallSubId:json['mallSubId'],
        mallCategoryId:json['mallCategoryId'],
        comments:json['comments'],
        mallSubName:json['mallSubName']
    );
  }
}
