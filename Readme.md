# Todo Diaries
## 概要
iOS向けのTodo管理アプリです。
データは**クラウド**に保存されます。

以前制作した[Todo Memories](https://github.com/Yu357/TodoMemories)を改良し、データの管理にFirebase Cloud Firestoreを利用するよう変更しました。

## 特徴
アプリに登録したTodoはいつでも内容を確認したり、優先順位を変更したりできます。
またTodoを**達成済みTodo**として保存することができ、**過去に達成したTodoを振り返ることができます!**
日々の生活で達成したTodoを振り返ることで、**達成感**や**充実感**を獲得することにつながります。

データをクラウドで管理しているので、複数のApple製モバイルデバイスで同じTodoを参照できます。

## 制作時期
- 2022年2月
- 2022年6月 (データの冗長性の排除、コードのリファクタリング)

## 使用したフレームワークやライブラリ
- SwiftUI
- [Firebase](https://github.com/firebase/firebase-ios-sdk)
- [FirebaseUI](https://github.com/firebase/FirebaseUI-iOS)
- [Charts](https://github.com/danielgindi/Charts)
- [Introspect](https://github.com/siteline/SwiftUI-Introspect)

## スクリーンショット
<div style="display: flex; justify-content: space-between;">
  <img style="display: block; width: 30%;" src="https://i.imgur.com/9pnp9pB.png"/>
  <img style="display: block; width: 30%;" src="https://i.imgur.com/1Y5il0D.png"/>
  <img style="display: block; width: 30%;" src="https://i.imgur.com/wSTTtei.png"/>
</div>
