```typescript
/**
 * ゲームのユーザーインターフェースを管理するクラス
 */
class GameUI {
  /**
   * ボードの描画
   * @param board 盤面の状態
   */
  drawBoard(board: string[][]) {
    console.log("=== オセロ盤 ===");
    for (let i = 0; i < 8; i++) {
      let row = "";
      for (let j = 0; j < 8; j++) {
        row += board[i][j] + " ";
      }
      console.log(row);
    }
    console.log("================");
  }

  /**
   * プレイヤーの石の配置位置の入力
   * @returns 座標（行、列）
   */
  inputMovePosition(): { row: number, col: number } {
    let row = parseInt(prompt("行を入力してください（0~7）："));
    let col = parseInt(prompt("列を入力してください（0~7）："));
    return { row, col };
  }

  /**
   * ゲームの進行状況の表示
   * @param turn 現在の手番（"先手"または"後手"）
   * @param passCount パス回数
   */
  showGameStatus(turn: string, passCount: number) {
    console.log("=== ゲーム進行状況 ===");
    console.log("現在の手番：" + turn);
    console.log("パス回数：" + passCount);
    console.log("===================");
  }

  /**
   * ゲーム結果の表示
   * @param result 勝利プレーヤーの表示
   */
  showGameResult(result: string) {
    console.log("=== ゲーム結果 ===");
    console.log(result);
    console.log("=================");
  }

  /**
   * 例外処理：不正な座標の入力
   */
  showErrorInputMessage() {
    console.log("不正な座標が入力されました。再入力してください。");
  }

  /**
   * 例外処理：置ける場所がない
   */
  showNoPlaceToPutMessage() {
    console.log("置ける場所がありません。パスしてください。");
  }
}
```
