file_slug: cpu
classname: CPU
filename: CPU.vue
responsibility: |
  - CPUの操作を管理します。
  - ゲームの状況に基づき、最適な石の置き場所を計算します。
  - 計算した位置に石を置く操作をBoardクラスに渡します。
methods: |
  - calculateBestMove(): 現在のボードの状態から最適な石の置き場所を計算します。
