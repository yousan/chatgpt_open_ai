```yaml
files:
  - file_slug: board
    classname: Board
    filename: Board.vue
    responsibility: |
      - 8x8のオセロボードを管理し、各マスの状態（空、黒石、白石）を保持します。
      - ゲーム開始時にボードを初期状態（中央に2つの黒石と2つの白石が交互に配置される）にセットします。
      - プレイヤーまたはCPUが石を置く操作を受け付け、その結果をボード上に反映します。
      - 挟まれた石の反転処理を行います。
      - 石を置ける場所を計算して、それを表示する機能を提供します。
      - ゲーム終了条件（ボード上に石を置く場所がなくなる、どちらかのプレイヤーの石がなくなる）を判断します。
    methods: |
      - initializeBoard(): ボードを初期状態に設定します。
      - placeStone(x: number, y: number, color: 'black' | 'white'): 指定された位置に石を置き、必要なら石の反転処理を実行します。
      - calculateValidMoves(color: 'black' | 'white'): 指定された色の石を置ける場所を計算します。
      - isGameOver(): ゲーム終了条件をチェックし、終了していたらtrueを返します。
      - getScore(): 現在のスコア（黒石と白石の数）を計算して返します。

  - file_slug: game_controller
    classname: GameController
    filename: GameController.vue
    responsibility: |
      - ゲーム全体の進行を管理します。
      - ターン制御、プレイヤーとCPUの操作、ゲーム終了判定、スコア表示、勝敗表示などゲームの主要な流れを司ります。
    methods: |
      - startGame(): ゲームを開始し、初期化処理を行います。
      - switchTurn(): ターンを交代します。
      - playerMove(x: number, y: number): プレイヤーが石を置く位置を選択した際の処理を行います。
      - cpuMove(): CPUが自動で石を置く処理を行います。
      - checkGameOver(): ゲーム終了条件をチェックし、必要ならゲーム終了処理を行います。
      - restartGame(): ゲーム終了後、新たにゲームを開始するための処理を行います。

  - file_slug: player
    classname: Player
    filename: Player.vue
    responsibility: |
      - プレイヤーのアクションを管理します。
      - マウスやタッチ操作によって石を置くマスを選択します。
      - プレイヤーが石を置く操作をBoardクラスに渡します。
    methods: |
      - chooseMove(): ユーザーインターフェイスから石を置く位置を選択します。

  - file_slug: cpu
    classname: CPU
    filename: CPU.vue
    responsibility: |
      - CPUの動作を管理します。
      - ゲームの現状を考慮して、最適な石を置く場所を計算します。
      - 石を置く操作をBoardクラスに渡します。
    methods: |
      - calculateMove(): ゲームの現状から、最適な石を置く位置を計算して選択します。
```
