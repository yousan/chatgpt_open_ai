```yaml
files:
  - file_slug: game
    classname: Game
    filename: game.ts
    responsibility: ゲームの進行と結果表示を管理する
    methods:
      - start(): ゲームを開始する処理
      - play(): プレイヤーとCPUの手番を交互に行う処理
      - updateGameStatus(): ゲームの状態を更新する処理
      - isGameOver(): ゲーム終了条件を判定する処理
      - displayResult(): 勝敗の結果を表示する処理
```
