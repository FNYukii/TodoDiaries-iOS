# Todo Diaries
## 概要
iOS向けのTodo管理アプリです。
Firebase Cloud Firestoreを使用しており、データはクラウドに保存されます。
Apple純正アプリのような、シンプルなインターフェースを実装しています。

以前制作した[Todo Memories](https://github.com/Yu357/TodoMemories)の進化版のようなアプリです。

## 特徴
アプリに登録したTodoはいつでも内容を確認したり、優先順位を変更したりできます。
またTodoを**達成済みTodo**として保存することができ、**過去に達成したTodoを振り返ることができます!**
日々の生活で達成したTodoを振り返ることで、達成感や充実感を獲得することにつながります。

データをクラウドで管理しているので、複数のApple製モバイルデバイスで同じTodoを参照できます。

## 制作時期
2022年2月 ~ 2022年6月

## 制作経緯
2021年10月に制作し始めた[Todo Memories](https://github.com/Yu357/TodoMemories)を日常生活でしばらく使っていた私は、「**このTodoをクラウドで管理してみたい**」と考える日々を送っていました。
そして2022年2月に学校で開催された2週間のハッカソンをきっかけに、この**Todo Diaries**の制作に取り組みました。

基本的な仕様はTodo Memoriesと同じですが、データをローカルではなく**クラウドで管理**できるようにし、UIの再設計も行いました。
ハッカソンで発表した後も開発を続け、ユーザビリティの向上からデータ読み取りロジックの効率化などを行いました。アプリを私生活で実際に使用し、感じた不満や見つけた不具合をもとに**数ヶ月間でさまざまな改善**を行いました。

2022年6月現在、このTodo Diariesを日常で使って生活しています。
約5ヶ月間毎日のように使用しているので、統計画面の達成グラフもなかなか見栄えの良いものになりました。
シンプルなUIや達成したことの振り返り機能などが非常に便利で、**私の生活に役立っています!**

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
