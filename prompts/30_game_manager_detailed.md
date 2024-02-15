file_slug: game_manager
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
