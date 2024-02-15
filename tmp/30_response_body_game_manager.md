```yaml
files:
  - file_slug: board
    classname: Board
    filename: Board.vue
    responsibility: |
      - 8x8のボード上の各マスの状態を管理します。
      - 初期状態で中央に黒石2つと白石2つを配置します。
      - 石を置く、石の反転を行う機能を提供します。
      - 石を置ける場所を計算して表示します。
      - ゲーム終了時の盤面上の石の数からスコアを計算します。
    methods: |
      - initializeBoard(): ボードを初期状態に設定します。
      - placeStone(x: number, y: number, color: string): 指定された位置に石を置き、反転処理を行います。
      - getValidMoves(color: string): 指定された色の石を置ける位置のリストを返します。
      - calculateScore(): 各色の石の数を計算し、スコアを返します。

  - file_slug: player
    classname: Player
    filename: Player.vue
    responsibility: |
      - プレイヤーの情報（プレイヤーの色など）と行動（石を置く）を管理します。
      - ユーザーの入力（マウスやタッチ）に対して石を置く操作を行います。
    methods: |
      - chooseMove(board: Board): ユーザーの入力に応じて石を置く位置を選択します。

  - file_slug: cpu_player
    classname: CpuPlayer
    filename: CpuPlayer.vue
    responsibility: |
      - CPUプレイヤーの行動を管理します。
      - 最適な石を置く場所を計算し、自動的に石を置きます。
    methods: |
      - chooseMove(board: Board): ボードの現在の状態を分析し、最適な場所に石を置きます。

  - file_slug: game_manager
    classname: GameManager
    filename: GameManager.vue
    responsibility: |
      - ゲーム全体の進行管理を行います。
      - ターンの管理、プレイヤーとCPUの操作を交互に行わせます。
      - ゲームの開始、終了、リスタートを管理します。
    methods: |
      - startGame(): ゲームを開始します。ボードの初期化、プレイヤーとCPUの準備を行います。
      - switchTurn(): ターンを交代します。
      - endGame(): ゲームを終了し、勝敗を表示します。
      - restartGame(): ゲームをリスタートします。ボードと各プレイヤーの状態を初期化します。
```
