## webお薬手帳

#### 概要
<hr>
医療機関からの医薬品処方内容の記録や共有を目的としたアプリケーション

#### コンセプト
<hr>
医療従事者とユーザーを繋げる

#### バージョン情報
<hr>
Ruby 2.6.5<br>
Rails 5.2.4<br>
Postgresql 13.1<br>

#### 機能一覧
<hr>
1. ユーザー登録機能<br>
  名前、メールアドレス、パスワードは必須<br>
2. 医療機関登録機能<br>
  医療機関名、メールアドレス、パスワードは必須<br>
3. ログイン機能<br>
4. パスワード再設定機能<br>
5. 処方内容表示機能<br>
  表示させることができる医療機関をユーザーが設定可能<br>
6. 処方内容記録機能<br>
7. 処方内容編集機能<br>
8. 処方内容削除機能<br>
  記録・編集・削除は医療機関のみ実行可能<br>
9. 医療機関いいね機能<br>

#### カタログ設計
<hr>
https://docs.google.com/spreadsheets/d/1gsgnXWy--47LMxwDWEqJtHLqluEmE2CKlJxH5F59UeA/edit?usp=sharing<br>

#### テーブル設計
<hr>
ER図：https://drive.google.com/file/d/1uqXjACQV76IF2b9Xvb0-5NKoeaZvXI4m/view?usp=sharing<br>
テーブル:https://docs.google.com/spreadsheets/d/19-v_z6cjIUZsJXcJYlrItew4ti7sqePg3G6ZdAY89j0/edit#gid=0<br>

#### 画面遷移図
<hr>
https://drive.google.com/file/d/19SgCUnvvmOYiV5g9kLXdYVX8FSyhyxXo/view?usp=sharing<br>

#### 画面ワイヤーフレーム
<hr>
保留：cacooへのリンク<br>

#### 使用予定Gem
devise<br>
