utils.py:

```python
import re


def validate_input(input_str, valid_range):
    """
    入力の検証を行う関数です。
    
    Parameters:
        - input_str (str): ユーザーからの入力文字列
        - valid_range (list): 有効な範囲のリスト
        
    Returns:
        - int: 入力文字列が有効な場合は変換した数値、無効な場合はNone
    """
    try:
        input_num = int(input_str)
        if input_num in valid_range:
            return input_num
    except ValueError:
        pass
    return None

    
def display_message(message):
    """
    メッセージの表示を行う関数です。
    
    Parameters:
        - message (str): 表示するメッセージ
    """
    print(message)

