const serviceUrl = 'https://wxmini.baixingliangfan.cn/baixing/'; //此端口针对于正版用户开放，可自行fiddle获取。

const servicePath = {
  'homePageContent': serviceUrl + 'wxmini/homePageContent', // 商家首页信息
  'homePageHotContent': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl + 'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById': serviceUrl + 'wxmini/getGoodDetailById',
};
