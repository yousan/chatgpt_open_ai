- あなたは優秀なNuxt.jsのエンジニアとして、Nuxt.jsで動くコードをTypeScriptで返答してください。
- ソースコードはマークダウン形式で提示してください。
- ソースコードのクラス定義、関数定義の冒頭にその機能のコメントを必ず記載してください。

# 仕様書
- ウェブ上で動作可能なオセロゲームを作成したいです。

# 今回の指示
- あなたは優秀なNuxt.jsのエンジニアです。
- 次の仕様を満たすシステム制作において、必要なクラスの詳細設計を行ってください。
- 出力形式はyamlにして、マークダウン形式で出力してください。
- ソースコードのファイルでは下記のように、ファイル名（filename）、クラス名（classname）、責務（responsibility）、メソッド（methods）を記載してください。
- ファイル名についてはスラッシュをいれず、フラットなファイル構造としてください。
- 責務については文章量が増えてもよいので網羅的に、抜け漏れが無いように記載してください。

```yaml
files:
  - file_slug:
  - classname:
  - filename:
  - responsibility:
  - methods
```

# 仕様書
オセロの定義、ルール:

1. 盤面は8x8のマス目で構成され、マス目には黒と白の石が交互に配置される。
2. ゲーム開始時、盤面の中央には黒石と白石が交互に配置される特定の配置が行われる。
3. プレイヤーとCPUは交互に石を配置し、石が相手の石で挟まれた場合、挟まれた石は裏返る。
4. 石を配置する際、石を置いた場所の上下左右斜め方向に挟まれた相手の石を裏返すことができる。
5. 石を置く場所がない場合はパスとなり、相手の番になる。
6. ゲーム終了条件は以下のいずれかを満たした時となる:
   - 盤面が全て埋まっている。
   - どちらかの色の石が全て無くなった。
   - 両者が石を置く場所がない状態が連続した。

システムの仕様書:

1. プレイヤーが先手となる。
2. 盤面は8x8のマス目とし、初期配置を黒石と白石が交互に配置する。
3. プレイヤーは入力を受け取り、石を配置する。
4. CPUの手番では、石の配置を決定するためのアルゴリズムを実装する。
5. 石の配置の有効性を保証するために、配置しようとするマスの上下左右斜め方向に相手の石があるかどうかを確認する。
6. 盤面の状態を更新し、石を裏返す必要がある場合は裏返す。
7. ゲーム終了条件を判定し、終了条件が満たされた場合は終了処理を行う。
8. ゲーム終了後に、勝敗の判定を行い、結果を表示する。

以上が、オセロゲーム作成のためのシステムの仕様書となります。
# 今回の指示
filename: Helper.js
classname: Helper
responsibility: ゲームで使用するヘルパー関数を提供する
methods:
  - isValidMove: 石の配置が有効かどうかを確認する
  - flipStones: 石を裏返す
  - checkGameEnd: ゲーム終了条件を判定する