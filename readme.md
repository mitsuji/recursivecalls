# 関数の再帰呼び出しについて調べる

## 気になったこと
	
* 関数の再帰呼び出し とは

* 末尾再帰, 末尾呼び出し最適化

* 関数の再帰呼び出しは while や for の代わりになるか


## 結果


### 無限ループ


| ソース         | 言語             | 最適化 | 結果 |
|--------------|----------------- | ----- | ---- |
| [frec.c](c/frec.c)       | C                |       | x: 261837 で Segmentation fault |
| 〃           | 〃                | -O2   | OK |
| [FRec.java](java/FRec.java)    | Java             |       | x: 5182 で StackOverflowError |
| [frec.js](js/frec.js)      | JavaScript       |       | x: 10454 で RangeError: Maximum call stack size exceeded |
| [FRec.hs](haskell/FRec.hs)      | Haskell          |       | OK |
| [frec.rkt](lisp/frec.rkt)     | Racket          |       | OK |
	
	

		
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
| [series1.rkt](lisp/series1.rkt)  | Racket           |       |      | (series 1000000000) で 強制終了(OOM) |
| [series2.rkt](lisp/series2.rkt)  | 〃               |○     |       | OK |


### 非効率な再帰の簡約
再帰回数に連動して式が大きくなる -> 一時保存のためのメモリが大量に必要
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

### 末尾再帰の簡約
式のサイズが一定、最適化でjump に書き換え可能
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


  * 関数の再帰呼び出しは while や for の代わりになるか
    * C, Java, JavaScrpt -> ならない (Cは最適化で動く場合もあるが実用性なさそう)
    * Haskell, Racket -> なる (末尾再帰にする)


  * 関数の再帰呼び出しを使うときに注意すること
    * C, Java, JavaScrpt のような一般的な言語では Stack Overflow に注意
      * より安全、高効率な代替手段を検討する
      * どうしても使う場合は再帰回数の上限に注意する


   * 末尾呼び出し最適化
      * C には、末尾呼び出し最適化があるが、最適化オプション使用時のみ有効
      * Java, JavaScrpt には、末尾呼び出し最適化はない (JavaScript は仕様はあるけど実質的に使えない)
      * Haskell, Racketのような関数型言語 には、末尾呼び出し最適化がある
        * Haskellのような遅延評価言語では、あわせて正格評価も意識する必要がある

  * 最適化がもろもろ解決する場合もあるが、最適化前提のコードは混乱のもと
    * 最適化しないと動かないコードは書かないほうがいい
    * 最適化なしでも動いて、最適化すると速くなるコードはOK

