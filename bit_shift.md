

## 移走最后出现的 1
```cpp
a & (a-1)
```


## a 只出现 1 次，其他都出现 2 次
数据模型是
```
a bb cc
```
`a ^ b ^ b = a`

在数组中，a 只出现一次，其他都出现两次，则可以利用这个公式

把只出现一次的数字挑出来

## a 只出现 1 次， b 只出现 1次，其他出现 2 次
数据模型是
```
a b cc dd
```

求得 
```
a^b^c^c^d^d = a^b
```
按照某一位为 1 说明是 a 和 b 的区别，按照这一位把所有数分两个组，

则数据模型变为 
```
a cc
b dd 
```
就转化为上面的已知问题。


## a 只出现 1 次，其他都出现 3 次
数据模型是
```
a bbb ccc
```

大众解法
```cpp
bits = new int[32];
for(num : nums) {
    for(i=0;i<32;i++) {
        // 每一位加和
    }
}

result = 0;
for(i=0;i<32;i++) {
    // 每一位 %3 即可
}
```

我一直看不懂这个位的解法。
```cpp
ones=0;
twos=0;

for(num : nums) {
    // 如果某一位 ones 上次已经计数了一个
    // 并且 num 本次又来了一个
    // 那么 twos 就新增计位  
    // 遗留:如果本来是有计位，twos 没有新增计位, ones 新增后，twos 要清0 
    twos |= ones & num;
    // ones 偶数个计位0 奇数个计位1（感觉就是带溢出性质的计数）
    ones ^= num;

    // 然后把 twos 和 ones 同时计位的清掉 就是加和为 3 的变为 0
    three = twos & ones;
    twos &= ~three;
    ones &= ~three;
}
```


