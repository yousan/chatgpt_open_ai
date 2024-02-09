/**
 * メインの実行ファイル
 */
class Main {
  /**
   * ゲームの開始
   */
  start() {
    // 1. ゲームの初期化
    const board = this.initializeBoard();

    // 6. 盤面の表示
    this.displayBoard(board);

    // 2. ゲームの進行
    this.play(board);

    // 7. ゲーム終了
    this.end(board);
  }

  /**
   * ゲームの進行
   * @param {string[][]} board - 盤面の石の配置
   */
  play(board: string[][]) {
    const player1 = 'B'; // 先手
    const player2 = 'W'; // 後手
    let currentPlayer = player1; // 現在のプレーヤー
    let consecutivePasses = 0; // パスの回数

    while (true) {
      const validMoves = this.getValidMoves(board, currentPlayer);

      if (validMoves.length === 0) {
        // プレーヤーがパスの場合
        consecutivePasses++;

        if (consecutivePasses === 2) {
          // プレーヤーが2回続けてパスした場合、ゲーム終了
          break;
        }

        console.log(`${currentPlayer}のターン: パス`);
      } else {
        // プレーヤーが石を置く場合
        consecutivePasses = 0;

        console.log(`${currentPlayer}のターン`);
        const [row, col] = this.getPlayerInput();

        if (this.isValidMove(board, currentPlayer, row, col)) {
          // 石を置く処理
          this.placeStone(board, currentPlayer, row, col);

          // 盤面の表示
          this.displayBoard(board);

          // プレーヤーの切り替え
          currentPlayer = currentPlayer === player1 ? player2 : player1;
        } else {
          console.log('不正な座標が入力されました。再入力してください。');
        }
      }
    }
  }

  /**
   * ゲームの終了
   * @param {string[][]} board - 盤面の石の配置
   */
  end(board: string[][]) {
    // 盤面の石の数を数える
    let blackCount = 0;
    let whiteCount = 0;

    for (let row = 0; row < 8; row++) {
      for (let col = 0; col < 8; col++) {
        if (board[row][col] === 'B') {
          blackCount++;
        } else if (board[row][col] === 'W') {
          whiteCount++;
        }
      }
    }

    // 勝利プレーヤーの表示と結果の表示
    if (blackCount > whiteCount) {
      console.log('黒の勝利');
      console.log(`黒: ${blackCount} 石, 白: ${whiteCount} 石`);
    } else if (whiteCount > blackCount) {
      console.log('白の勝利');
      console.log(`黒: ${blackCount} 石, 白: ${whiteCount} 石`);
    } else {
      console.log('引き分け');
      console.log(`黒: ${blackCount} 石, 白: ${whiteCount} 石`);
    }
  }

  /**
   * ゲームの初期化
   * @returns {string[][]} - 初期化された盤面の石の配置
   */
  initializeBoard(): string[][] {
    const board: string[][] = [];

    for (let row = 0; row < 8; row++) {
      board[row] = [];
      for (let col = 0; col < 8; col++) {
        board[row][col] = ' ';
      }
    }

    board[3][3] = 'W';
    board[3][4] = 'B';
    board[4][3] = 'B';
    board[4][4] = 'W';

    return board;
  }

  /**
   * 盤面の石の配置を表示する
   * @param {string[][]} board - 盤面の石の配置
   */
  displayBoard(board: string[][]) {
    for (let row = 0; row < 8; row++) {
      let rowStr = '';
      for (let col = 0; col < 8; col++) {
        if (board[row][col] === 'B') {
          rowStr += 'B ';
        } else if (board[row][col] === 'W') {
          rowStr += 'W ';
        } else {
          rowStr += '- ';
        }
      }
      console.log(rowStr);
    }
  }

  /**
   * プレーヤーの入力を取得する
   * @returns {number[]} - プレーヤーが入力した座標
   */
  getPlayerInput(): number[] {
    const readlineSync = require('readline-sync');
    const input = readlineSync.question('石を置く座標（行 列）を入力してください: ');
    const [row, col] = input.split(' ').map((str) => parseInt(str));
    return [row, col];
  }

  /**
   * プレーヤーが置ける場所を取得する
   * @param {string[][]} board - 盤面の石の配置
   * @param {string} currentPlayer - 現在のプレーヤー
   * @returns {number[][]} - プレーヤーが置ける場所の座標のリスト
   */
  getValidMoves(board: string[][], currentPlayer: string): number[][] {
    const validMoves: number[][] = [];

    for (let row = 0; row < 8; row++) {
      for (let col = 0; col < 8; col++) {
        if (this.isValidMove(board, currentPlayer, row, col)) {
          validMoves.push([row, col]);
        }
      }
    }

    return validMoves;
  }

  /**
   * 石を置くことができるかどうかを判定する
   * @param {string[][]} board - 盤面の石の配置
   * @param {string} currentPlayer - 現在のプレーヤー
   * @param {number} row - 石を置く座標の行
   * @param {number} col - 石を置く座標の列
   * @returns {boolean} - 石を置くことができるかどうか
   */
  isValidMove(board: string[][], currentPlayer: string, row: number, col: number): boolean {
    // 既に石が置かれている場所には石を置けない
    if (board[row][col] !== ' ') {
      return false;
    }

    // 8方向に対して挟むことができる石があるかどうかを判定する
    for (let dRow = -1; dRow <= 1; dRow++) {
      for (let dCol = -1; dCol <= 1; dCol++) {
        if (dRow === 0 && dCol === 0) {
          continue;
        }
        if (this.canFlip(board, currentPlayer, row, col, dRow, dCol)) {
          return true;
        }
      }
    }

    return false;
  }

  /**
   * 石を置く処理
   * @param {string[][]} board - 盤面の石の配置
   * @param {string} currentPlayer - 現在のプレーヤー
   * @param {number} row - 石を置く座標の行
   * @param {number} col - 石を置く座標の列
   */
  placeStone(board: string[][], currentPlayer: string, row: number, col: number) {
    board[row][col] = currentPlayer;

    for (let dRow = -1; dRow <= 1; dRow++) {
      for (let dCol = -1; dCol <= 1; dCol++) {
        if (dRow === 0 && dCol === 0) {
          continue;
        }
        if (this.canFlip(board, currentPlayer, row, col, dRow, dCol)) {
          this.flipStones(board, currentPlayer, row, col, dRow, dCol);
        }
      }
    }
  }

  /**
   * 挟むことができる石があるかどうかを判定する
   * @param {string[][]} board - 盤面の石の配置
   * @param {string} currentPlayer - 現在のプレーヤー
   * @param {number} row - 石を置く座標の行
   * @param {number} col - 石を置く座標の列
   * @param {number} dRow - 方向の行の増分
   * @param {number} dCol - 方向の列の増分
   * @returns {boolean} - 挟むことができる石があるかどうか
   */
  canFlip(board: string[][], currentPlayer: string, row: number, col: number, dRow: number, dCol: number): boolean {
    const opponent = currentPlayer === 'B' ? 'W' : 'B';
    let x = row + dRow;
    let y = col + dCol;

    if (!this.isValidPosition(x, y) || board[x][y] !== opponent) {
      return false;
    }

    while (true) {
      x += dRow;
      y += dCol;

      if (!this.isValidPosition(x, y)) {
        return false;
      }

      if (board[x][y] === ' ') {
        return false;
      }

      if (board[x][y] === currentPlayer) {
        return true;
      }
    }
  }

  /**
   * 石をひっくり返す
   * @param {string[][]} board - 盤面の石の配置
   * @param {string} currentPlayer - 現在のプレーヤー
   * @param {number} row - 石を置く座標の行
   * @param {number} col - 石を置く座標の列
   * @param {number} dRow - 方向の行の増分
   * @param {number} dCol - 方向の列の増分
   */
  flipStones(board: string[][], currentPlayer: string, row: number, col: number, dRow: number, dCol: number) {
    const opponent = currentPlayer === 'B' ? 'W' : 'B';
    let x = row + dRow;
    let y = col + dCol;

    while (board[x][y] === opponent) {
      board[x][y] = currentPlayer;
      x += dRow;
      y += dCol;
    }
  }

  /**
   * 座標が正しい範囲内かどうかを判定する
   * @param {number} row - 判定する座標の行
   * @param {number} col - 判定する座標の列
   * @returns {boolean} - 座標が正しい範囲内かどうか
   */
  isValidPosition(row: number, col: number): boolean {
    return row >= 0 && row < 8 && col >= 0 && col < 8;
  }
}

// ゲームの開始
const main = new Main();
main.start();
