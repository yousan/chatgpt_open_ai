/**
 * GameManagerクラス
 * ゲームの進行や表示を制御するクラス
 */
class GameManager {
  /**
   * ゲームの開始を制御するメソッド
   */
  startGame() {
    // ゲームの初期化処理
    this.initializeGame();

    // ゲームの進行処理
    while (!this.isGameOver()) {
      this.displayBoard();
      this.displayPlayerTurn();
      const input = this.getPlayerInput();

      if (this.isValidInput(input)) {
        const [row, col] = input;
        if (this.isValidMove(row, col)) {
          this.placeStone(row, col);
          this.flipStones(row, col);
          this.nextPlayerTurn();
        } else {
          this.displayErrorMessage();
        }
      } else {
        this.displayErrorMessage();
      }
    }

    // ゲーム終了処理
    this.displayBoard();
    this.displayWinner();
  }

  /**
   * 勝者を表示するメソッド
   */
  displayWinner() {
    const blackCount = this.countStones("B");
    const whiteCount = this.countStones("W");

    if (blackCount > whiteCount) {
      console.log("黒の勝利です！");
    } else if (blackCount < whiteCount) {
      console.log("白の勝利です！");
    } else {
      console.log("引き分けです！");
    }
  }

  /**
   * エラーメッセージを表示するメソッド
   */
  displayErrorMessage() {
    console.log("無効な座標です。もう一度入力してください。");
  }

  // 以下、省略
}
