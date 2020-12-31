import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Zjpage extends StatefulWidget {
  Zjpage({Key key}) : super(key: key);

  @override
  _ZjpageState createState() => _ZjpageState();
}

class _ZjpageState extends State<Zjpage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  TabController _controller1;
  List<Image> imgs = [
    //建立了一个图片数组
    Image.network(
      "https://images.unsplash.com/photo-1477346611705-65d1883cee1e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1498550744921-75f79806b8a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
  ];
  @override
  void initState() {
    super.initState();
    gethttp1();
    _controller = TabController(length: 6, vsync: this);
//    //非web检查更新
//    if (!PlatformExt.isWeb) {
//      checkUpgrade(context);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("追剧"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
//              showSearch();
            },
            icon: Icon(Icons.search),
          )
        ],
        bottom: TabBar(
          controller: _controller,
          labelColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.white,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: "今日"),
            Tab(text: "本月"),
            Tab(text: "电影"),
            Tab(text: "新剧"),
            Tab(text: "日剧"),
            Tab(text: "全部"),
          ],
        ),
      ),
      body:  TabBarView(controller: _controller, children: <Widget>[
        new first.First(),
        new second.Second(),
        new third.Third(),
      ]),
//      drawer: HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: "资讯",
        backgroundColor: Colors.blueAccent,
        onPressed: () {
//          Navigator.pushNamed(context, "/Szpage");
        },
        child: Icon(
          Icons.inbox,
          color: Colors.white,
        ),
      ),
    );
  }

  void gethttp1() async {
//  var body = "<html><head><title>80页笔记看遍机器学习基本概念、算法、模型，帮新手少走弯路</title></head> <body></body></html>>";

    //请求HTML数据
    var response = await new Dio().get(
        "https://v.sogou.com/");

    //解析返回的数据，类似 val doc = Jsoup.connect(text).get()
    var document = parse(response.data);

    //获取html标签，类似val links = doc.select("title")
    var title = document.querySelector("title");

    //获取html body标签，类似 val body = doc.getElementsByTag("body")
    var body = document.getElementsByTagName("body");
    //下面获取html的图片，暂未找到好的解决办法，使用的最笨的截取
    var scripts = body[0].getElementsByTagName("script");
    print(title.text);
    for(int i=0;i< scripts.length;i++){
      //将获取的html标签转换成String字符串
      var script = scripts[i].outerHtml.toString();
      //判断字符串是否包含BASE_DATA
      if (script.indexOf("BASE_DATA") != -1) {
        //处理得到image图片
        var image = script.substring(script.indexOf("coverImg"), script.indexOf("commentInfo:"))
            .replaceAll("coverImg:", "").replaceAll("\'", "").replaceAll("},", "");
        print(image);
      }
    }
  }


}