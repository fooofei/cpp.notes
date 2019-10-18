

# 二分查找

***经常混淆二分查找的使用，下定决心做到使用时得心应手***

二分查找的代码影响因素有

- 升序降序 
- 比较函数返回值 true/false (即 大于小于等于)

⚠️ 排列顺序和比较函数不能交叉使用

## Golang 实现的二分查找

API
```golang
sort.Search 
返回值是索引
```
重要部分
```golang
h := int(uint(i+j) >> 1) // avoid overflow when computing h
if !f(h) {
    i = h + 1 // preserves f(i-1) == false
} else {
    j = h // preserves f(j) == true
}
```
返回值：第一个使 cmp func 为 true 的 **索引**

Golang 实现的二分查找有序序列在 cmp func 上作用效果为
```
false false false ... false true true ... true
```

则

有序序列为降序时，应使用 `<` `<=`
```golang
cmp = func(i) {
    return a[i] < 4
}
```

```
5 4 3 2 1 
F F T T T
```
或者
```golang
cmp = func(i) {
    return a[i] <= 4
}
```
```
5 4 3 2 1
F T T T T
```

有序序列为升序时，应使用 `>` `>=`
```golang
cmp = func(i) {
    return a[i] >= 4
}
```
```
1 2 3 4 5 
F F F T T
``` 


❌ 交叉使用, 在降序上使用 `>` 

```golang
cmd = func(i) {
    return a[i]> 4
}
```
```
5 4 3 2 1
第一次 3 false
第二次 2 false
第三次 1 false
无法查找到结果
```

## C++ 实现的二分查找
API
```cpp
lower_bound()
...
if cmp(mid, target) {
    i = mid+1;
}
...
```
cmp = less



API **最接近 Golang**
```cpp
upper_bound()
...
if !cmp(target, mid) {
    i= mid+1;
}
...
```


⚠️ `lower_bound` 和 `upper_bound` 的 `cmp` 参数位置是相反的

因为 C++ 没有 Golang 那样闭包的语言特性，导致 func 的两个参数位置变化，

会引起比较结果的不同，C++ 的比较也因此更复杂。
