```typescript
// Boardクラスの定義
class Board {
  private board: string[][]; // ボードの状態を格納する2次元配列
  private currentPlayer: string; // 現在の手番のプレーヤー
  private blackCount: number; // 黒石の数
  private whiteCount: number; // 白石の数
  private passCount: number; // パスの回数

  constructor() {
    this.board = []; // ボードの初期化
    this.currentPlayer = 'B'; // 先手は黒石である
    this.blackCount = 0;
    this.whiteCount = 0;
    this.passCount = 0;

    // ボードの初期化
    for (let i = 0; i < 8; i++) {
      const row: string[] = [];
      for (let j = 0; j < 8; j++) {
        row.push('');
      }
      this.board.push(row);
    }

    // 初期配置の設定
    this.board[3][3] = 'W';
    this.board[4][4] = 'W';
    this.board[3][4] = 'B';
    this.board[4][3] = 'B';

    this.blackCount = 2;
    this.whiteCount = 2;
  }

  // 石の追加
  public addStone(row: number, col: number): void {
    if (this.isValidMove(row, col)) {
      this.board[row][col] = this.currentPlayer;
      if (this.currentPlayer === 'B') {
        this.blackCount++;
      } else {
        this.whiteCount++;
      }
      this.flipStones(row, col); // 石のひっくり返し処理
      this.changePlayer(); // 手番の切り替え
      this.passCount = 0; // パス回数のリセット
    } else {
      throw new Error('Invalid move'); // 不正な座標の場合はエラーをスロー
    }
  }

  // 石のひっくり返し
  private flipStones(row: number, col: number): void {
    const directions: number[][] = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1], [1, 0], [1, 1]
    ];

    for (const direction of directions) {
      const dx = direction[0];
      const dy = direction[1];
      let x = row + dx;
      let y = col + dy;

      // 相手プレーヤーの石を挟むまでループ
      while (x >= 0 && x < 8 && y >= 0 && y < 8 && this.board[x][y] === this.getOppositePlayer()) {
        x += dx;
        y += dy;
      }

      // 周囲が自分の石で挟まれている場合、石をひっくり返す
      if (x >= 0 && x < 8 && y >= 0 && y < 8 && this.board[x][y] === this.currentPlayer) {
        let flipX = row + dx;
        let flipY = col + dy;

        while (flipX !== x || flipY !== y) {
          this.board[flipX][flipY] = this.currentPlayer;
          if (this.currentPlayer === 'B') {
            this.whiteCount--;
            this.blackCount++;
          } else {
            this.whiteCount++;
            this.blackCount--;
          }
          flipX += dx;
          flipY += dy;
        }
      }
    }
  }

  // 石が置けるかどうかの判定
  private isValidMove(row: number, col: number): boolean {
    // 既に石が置かれている場合は置けない
    if (this.board[row][col] !== '') {
      return false;
    }

    // 8方向に対して周囲の石をチェック
    const directions: number[][] = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1], [1, 0], [1, 1]
    ];

    for (const direction of directions) {
      const dx = direction[0];
      const dy = direction[1];
      let x = row + dx;
      let y = col + dy;

      // 相手プレーヤーの石を挟むまでループ
      while (x >= 0 && x < 8 && y >= 0 && y < 8 && this.board[x][y] === this.getOppositePlayer()) {
        x += dx;
        y += dy;
      }

      // 周囲が自分の石で挟まれている場合、石を置ける
      if (x >= 0 && x < 8 && y >= 0 && y < 8 && this.board[x][y] === this.currentPlayer) {
        return true;
      }
    }

    return false; // 石を置ける場所がない場合は置けない
  }

  // 手番の切り替え
  private changePlayer(): void {
    this.currentPlayer = this.getOppositePlayer();
  }

  // 相手のプレーヤーを取得する
  private getOppositePlayer(): string {
    return this.currentPlayer === 'B' ? 'W' : 'B';
  }

  // パスする
  public pass(): void {
    this.changePlayer(); // 手番の切り替え
    this.passCount++; // パス回数をインクリメント

    if (this.passCount >= 2) {
      this.gameOver(); // ゲーム終了
    }
  }

  // ゲーム終了
  private gameOver(): void {
    // 石の数のカウントを取得
    const blackCount = this.blackCount;
    const whiteCount = this.whiteCount;

    // 勝利プレーヤーの表示と結果の表示
    if (blackCount > whiteCount) {
      console.log('The winner is Black (B)');
    } else if (blackCount < whiteCount) {
      console.log('The winner is White (W)');
    } else {
      console.log('The game is a draw');
    }

    console.log('Black (B): ' + blackCount);
    console.log('White (W): ' + whiteCount);
  }

  // 盤面の表示
  public printBoard(): void {
    console.log('    0 1 2 3 4 5 6 7');
    for (let i = 0; i < 8; i++) {
      let rowStr = i + ' |';
      for (let j = 0; j < 8; j++) {
        const stone = this.board[i][j];
        if (stone === '') {
          rowStr += ' ';
        } else {
          rowStr += stone;
        }
        rowStr += '|';
      }
      console.log(rowStr);
    }
  }
}

// ボードの初期化
const board = new Board();
board.printBoard();
```
