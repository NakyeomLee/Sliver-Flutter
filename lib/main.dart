import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// Sliver : 찢어진 조각이라는 의미 / 스크롤에 반응함
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView에는 sliver만 들어갈 수 있음
        slivers: [
          SliverAppBar(
            title: Text("앱바1"),
            pinned: false, // true(기본값)일땐 스크롤 왔다갔다해도 앱바 고정, false일땐 스크롤 내리면 앱바 사라졌다가 스크롤 끝까지 올리면 앱바 나타남
            floating: true, // 스크롤 쭉 내렸다가 살짝만 올려도 앱바 전체가 바로 나타남
            snap: true, // 앱바가 사라졌다 나타나는 동작(애니메이션)이 좀 더 부드러움 / floating과 snap은 쌍으로 많이 씀
            expandedHeight: 250, // 앱바의 높이 확장
            flexibleSpace: FlexibleSpaceBar( // flexibleSpace이 앱바의 확장된 높이를 씀 (광고나 영상 넣기에 좋음)
              title: Text("플레시블 스페이스"),
              centerTitle: true, // 타이틀이 중앙에 옴
              background: Image.network(
                "https://picsum.photos/200/300",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(color: Colors.blue, height: 300),
          ),

          SliverPersistentHeader(
            pinned: true, // 스크롤 왔다갔다해도 해당 요소 고정
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 50,
              maxHeight: 120,
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 30,
                  (context, index) {
                return ListTile(
                    title: Text("제목 $index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  // getter (알고만 있기 / 안써도 됨)
  @override
  double get maxExtent => maxHeight;

  // getter (알고만 있기 / 안써도 됨)
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}