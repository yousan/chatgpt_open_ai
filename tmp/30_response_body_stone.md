```js
// Stoneクラス: 石の色や状態を管理するクラス
class Stone {
  constructor(color) {
    this.color = color; // 石の色（"B" or "W"）
  }

  // 石の色を取得するメソッド
  getColor() {
    return this.color;
  }

  // 石の色を設定するメソッド
  setColor(color) {
    this.color = color;
  }
}

export default Stone;
```

上記のソースコードは、オセロの石を表す`Stone`クラスです。
`Stone`クラスの役割は、石の色や状態を管理することです。

`Stone`クラスには以下のメソッドが定義されています。

- `getColor()`: 石の色を取得するメソッドです。`this.color`を返します。
- `setColor(color)`: 石の色を設定するメソッドです。引数で渡された色を`this.color`に設定します。

このクラスによって、オセロの石の色や状態を管理することができます。
