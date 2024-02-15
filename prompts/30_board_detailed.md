file_slug: board
classname: Board
filename: Board.vue
responsibility: |
  - 8x8のグリッドを表示し、オセロの各マスを管理します。
  - 初期状態で中央に黒石2つと白石2つを配置します。
  - プレイヤーが石を置いた際に、石の反転処理を行います。
  - 石を置ける場所を計算し、ヒントとして表示します。
  - 各プレイヤーのスコアを計算し、表示します。
methods: |
  - initBoard(): ボードを初期化し、中央に石を配置します。
  - placeStone(x, y, color): 指定された位置に石を置き、必要に応じて石を反転させます。
  - computeValidMoves(color): 指定された色のプレイヤーが石を置ける場所を計算します。
  - updateScores(): プレイヤーのスコアを更新し、表示します。
  - checkGameOver(): ゲームが終了したかどうかをチェックし、終了していれば勝敗を表示します。
