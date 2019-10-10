

## C++ 如何使用 Sort


⚠️ 注意比较函数的 `last` `first` 顺序

```c++
struct data_t {
    int data;
};
```

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

也可以这样理解
```cpp
bool sort_cmp(const struct data_t& first, const struct data_t& last)
{
    return first.data < last.data;
}
// 通过调换 last first 顺序，把 cmp 理解为应该满足什么顺序。
// 如 cmp(first, last) 满足 cmp(last, first) 不满足，
//  cmp(last, first) = !cmp(first, last)
// 则发生交换
```


### 降序

```cpp
// 返回 true 表示要交换
bool sort_cmp(const struct data_t& first, const struct data_t& last)
{
    return first.data > last.data;
}

sort(vec.begin(), vec.end(), sort_cmp);
```

**strict weak ordering**

释义 https://www.boost.org/sgi/stl/StrictWeakOrdering.html

```cpp
bool sort_cmp(const struct data_t& first, const struct data_t& last)
{
    return first.data <= last.data;
}

sort(vec.begin(), vec.end(), sort_cmp);
```

为什么有这样的要求，我自己写排序是否会有这样的要求？

还是没找到原因。多个文章只是说了现象，和代码是某种实现。

不符合严格弱序的比较函数会导致崩溃，

从代码上讲就是某个循环没有正常退出。（我没理解，你不正常退出还有理了？难道不应该边界检查？）



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

### 降序
```golang
// Less reports whether the element with
// index i should sort before the element with index j.
func (s MyInts) Less(i, j int) bool {
	return s[i] > s[j]
}
sort.Sort(MyInts(vec))
```
