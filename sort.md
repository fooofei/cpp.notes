

## C++ 如何使用 Sort


**strict weak ordering**

释义 https://www.boost.org/sgi/stl/StrictWeakOrdering.html

```cpp
bool sort_cmp(const struct data_t& last, const struct data_t& first)
{
    // 最终为 first <= last // 不可以加 = 号
    return last.data <= first.data;
}

sort(vec.begin(), vec.end(), sort_cmp);
```

为什么有这样的要求，我自己写排序是否会有这样的要求？

还是没找到原因。多个文章只是说了现象，和代码是某种实现。

不符合严格弱序的比较函数会导致崩溃，

从代码上讲就是某个循环没有正常退出。（我没理解，你不正常退出还有理了？难道不应该边界检查？）


⚠️ 比较函数的 `last` `first` 顺序。

### 升序


```cpp
// 返回 true 表示要交换
bool sort_cmp(const struct data_t& last, const struct data_t& first)
{
    // 因为 last < first 进行交换，因此 最终为 first < last，为升序
    return last.data < first.data;
}

sort(vec.begin(), vec.end(), sort_cmp);
```


### 降序

```cpp
// 返回 true 表示要交换
bool sort_cmp(const struct data_t& last, const struct data_t& first)
{
    // 最终为 first > last
    return last.data > first.data;
}

sort(vec.begin(), vec.end(), sort_cmp);
```


## Golang 如何使用 Sort



### 升序 
```golang
// Less reports whether the element with
// index i should sort before the element with index j.
func (s MyInts) Less(i, j int) bool {
	return s[i] < s[j]
}
sort.Sort(MyInts(vec))
```

虽然 C++ 和 Golang 的比较函数同样的升序都是 `<` 比较，但是含义却相反。

如果做到升序，`first < last`，C++ 是说
```cpp
cmp(后，前)
{
    return 前 > 后;
}
然后满足的就发生交换
```
Golang 是
```golang
cmp(前，后)
{
    return 前 < 后
}
```

### 降序
```golang
// Less reports whether the element with
// index i should sort before the element with index j.
func (s MyInts) Less(i, j int) bool {
	return s[i] > s[j]
}
sort.Sort(MyInts(vec))
```
