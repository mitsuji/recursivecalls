# 関数の再帰呼び出しについて確認する

## 気になったこと
	
* 関数の再帰呼び出し とは

* 末尾再帰, 末尾呼び出し最適化 とは

* 関数の再帰呼び出しで無限ループできるか (while や for の代わりになるか)



## 結果


		
### 再帰関数 (級数)

| ソース         | 言語             |末尾再帰| 最適化 | 結果 |
|--------------|----------------- | ----- | ---- | ---- |
| [series.c](c/series.c)     | C                |       |      | series(1000000) で Segmentation fault |
| 〃            |〃                |      | -O2   | OK  |  
| [Series.java](java/Series.java)  | Java             |       |      | series(100000) で StackOverflowError |
| [series.js](js/series.js)    | JavaScript       |       |      | series(100000) で RangeError: Maximum call stack size exceeded  |
| [Series1.hs](haskell/Series1.hs)   | Haskell          |       |      | series 100000000 で stack overflow |
| 〃            |〃                 |      | -O2  | OK  |
| [Series2L.hs](haskell/Series2L.hs)  | Haskell(lazy)    |○      |      | series 100000000 0 で 強制終了(OOM) |
| 〃            |〃                |○      | -O2  | OK |
| [Series2S.hs](haskell/Series2S.hs)  | Haskell(strict)  |○      |      | OK (時間かかるけど) |
| 〃            |〃                |○      | -O2  | OK |
| [series1.rkt](lisp/series1.rkt)  | Racket           |       |      | (series 1000000000) で 強制終了(OOM) |
| [series2.rkt](lisp/series2.rkt)  | 〃               |○     |       | OK |



### 無限ループ

| ソース         | 言語             | 最適化 | 結果 |
|--------------|----------------- | ----- | ---- |
| [frec.c](c/frec.c)       | C                |       | x: 261837 で Segmentation fault |
| 〃           | 〃                | -O2   | OK |
| [FRec.java](java/FRec.java)    | Java             |       | x: 5182 で StackOverflowError |
| [frec.js](js/frec.js)      | JavaScript       |       | x: 10454 で RangeError: Maximum call stack size exceeded |
| [FRec.hs](haskell/FRec.hs)      | Haskell          |       | OK |
| [frec.rkt](lisp/frec.rkt)     | Racket          |       | OK |



### 関数呼び出しとスタック
	
* 関数の呼び出しはスタックを消費する (呼び出し元の情報を一時保存するため)
* C, Java, JavaScript のような一般的な言語ではスタックのサイズは有限で比較的小さい
* 関数の呼び出しを繰り返すとスタック不足におちいる 


### 再帰の簡約
	
#### 非効率な再帰
再帰回数に応じて一時的に作られる式が肥大化する -> メモリ不足
```
fun series(x) {
  if (x == 0)
    0
  else
    x + series(x-1)
}
```
```    
series (5)
5 + series(5-1)
5 + series(4)
5 + 4 + series(4-1)
5 + 4 + series(3)
5 + 4 + 3 + series(3-1)
5 + 4 + 3 + series(2)
5 + 4 + 3 + 2 + series(2-1)
5 + 4 + 3 + 2 + series(1)
5 + 4 + 3 + 2 + 1 + series(1-1)
5 + 4 + 3 + 2 + 1 + series(0)
5 + 4 + 3 + 2 + 1 + 0
9 + 3 + 2 + 1 + 0
12 + 2 + 1 + 0
14 + 1 + 0
15 + 0
15
```    

#### 末尾再帰
式のサイズが一定、最適化で jump命令(goto,while,for相当) に単純書き換え可能 -> 末尾呼び出し最適化
```
fun series(x, acc) {
  if (x == 0)
    acc
  else
    series(x-1, acc+x)
}
```
```    
series (5,0)
series (5-1,0+5)
series (4,5)
series (4-1,5+4)
series (3,9)
series (3-1,9+3)
series (2,12)
series (2-1,12+2)
series (1,14)
series (1-1,14+1)
series (0,15)
15
```    

    
    

	
	
## まとめ


  * 関数の再帰呼び出しで無限ループできるか (while や for の代わりになるか)
    * C, Java, JavaScrpt -> できない (Cは最適化で動く場合もあるが実用性なさそう)
    * Haskell, Racket -> できる (末尾再帰にする)


  * 関数の再帰呼び出しを使うときに注意すること
    * C, Java, JavaScrpt のような一般的な言語では、Stack Overflow に注意
      * より安全、高効率な代替手段を検討する
      * どうしても使う場合は再帰回数の上限に注意する
	
    * Haskell, Racket のような関数型言語では、一時的に作られる式の肥大化に注意
      * 末尾再帰にする
      * Haskellのような遅延評価言語では、あわせて正格評価も意識する
	
    * Java, JavaScript には、末尾呼び出し最適化はない
      * 末尾再帰で書いてもあまり意味がない
      * JavaScript は 仕様はあるけどほぼ実用化されていない (safariのみ)

    * C には、末尾呼び出し最適化がある
      * 最適化オプションの指定が必要
      * 末尾再帰じゃなくても、最適化オプションで動作可能なコードになることがある
      * 最適化オプションに依存したコードは混乱のもとなので避けたほうがいい
        * 最適化オプションなしでも動いて、つけると効率化されるコードはOK

    * Haskell, Racket のような関数型言語には、末尾呼び出し最適化がある
      * Haskell は最適化オプションでより効率のよいコードになることがある

