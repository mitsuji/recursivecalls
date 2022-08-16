# 関数の再帰呼び出しについて調べる

## 気になったこと
	
* 関数の再帰呼び出し とは

* 関数の再帰呼び出しは while や for の代わりになるか

* 末尾再帰, 末尾呼出し最適化 とは



## 結果


### 無限ループ


| ソース         | 言語             | 最適化 | 結果 |
|--------------|----------------- | ----- | ---- |
| [frec.c](c/frec.c)       | C                |       | x: 261837 で Segmentation fault |
| 〃           | 〃                | -O2   | OK |
| [FRec.java](java/FRec.java)    | Java             |       | x: 5182 で StackOverflowError |
| [frec.js](js/frec.js)      | JavaScript       |       | x: 10454 で RangeError: Maximum call stack size exceeded |
| [FRec.hs](haskell/FRec.hs)      | Haskell          |       | OK |
| [frec.rkt](lisp/frec.rkt)     | Racketl          |       | OK |
	
	

		
### 級数関数

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
| [series1.rkt](lisp/series1.rkt)  | Racket           |       |      | (series 1000000000) で 強制終了 |
| [series2.rkt](lisp/series2.rkt)  | 〃               |○     |       | OK |



	
	
## まとめ


  * 関数の再帰呼び出しは while や for の代わりになるか
    * C, Java, JavaScrpt -> ならない (最適化で動く場合もあるが実用性なさそう)
    * Haskell, Racket -> 末尾再帰にすればOK

	
  * 関数の再帰呼び出しを使うときに注意すること

    * C, Java, JavaScrpt のような一般的な言語では Stack Overflow に注意
      * より安全、高効率な代替手段を検討する
      * どうしても使う場合は再帰回数の上限に注意する

    * Haskell, Racketのような関数型言語 では末尾再帰を意識する

    * Haskellのような遅延評価言語では正格評価も意識する

    * 最適化がもろもろ解決する場合もあるが、最適化前提のコードは混乱のもと
