class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto; //小类别列表
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

  //工厂模式——用这种模式可以省略New关键字.factory 关键字的功能，当实现构造函数但是不想每次都创建该类的一个实例的时候使用。
  factory CategoryBigModel.fromJson(dynamic json) {
    return CategoryBigModel(
        mallCategoryId:json['mallCategoryId'],
        mallCategoryName:json['mallCategoryName'],
        comments:json['comments'],
        image:json['image'],
        bxMallSubDto:json['bxMallSubDto']
    );
  }
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
