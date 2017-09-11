


### MapReduce

- in python streaming, sys.stdin must run out, 
```python
for line in sys.stdin:
    continue
```
must run to end, cannot break at middle.

- mapreduce must print something, if not, will error occured, report io closed.


### Hbase shell

- hbase scan, only show row key.

```
scan '<table>', {FILTER=>'KeyOnlyFilter()' ,STARTROW=>'', STOPROW=>''}
```

- CF is meaning Column Family

- hbase data model `http://www.cnblogs.com/NicholasLee/archive/2012/09/13/2683272.html`

- hbase shell result redirect to file
```
echo "scan '<table>', {FILTER=>\"KeyOnlyFilter()\", LIMIT=>400000}"
| hbase shell > log.hbaseshell
```
- filter by one column value
```
scan '<table>', { COLUMNS => 'value:<column_name>', LIMIT => 10, 
FILTER => "ValueFilter( =, 'binary:<string>' )" }
```

- hbase table structure
```
  Table (
              Row key，List(
					SortedMap(
                  Column，list(
                    Value，Timestamp
                    )
                   )
				)
         )
```

`ref http://www.cnblogs.com/sunfie/p/4344942.html`

### SQL vs Hbase shell

sql| hbase
----|----
NULL| 命令大小写敏感<br>https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/<br>~ = hbase.scan.table.split.start, ! = hbase.scan.table.split.stop
create table [table_name] ([field_name], ...);| create ‘t1’, {NAME =] ‘f1’}, {NAME =] ‘f2’}, {NAME =] ‘f3’}<br>create ‘t1’, ‘f1’, ‘f2’, ‘f3’
insert into [talbe_name] ([field_name], ...) values (...);| bulk insert<br> put '[table_name]/[t1]', '[r1]', '[cf1]', '[value]' (f1 is new column name, value is the column value)
select * from [table_name] where ...; | get ‘t1’, ‘r1’
update [table_name] set [field_name]=... ; |put '[table_name]/[t1]', '[r1]', '[cf1]', '[value]' (t1 is table name, r1 is key name, cf1 is an existed column name, )
delete from [table_name] where ...; |  alter '[t1]' NAME=>'[cf1]',METHOD=>'delete'<br>delete '[t1]','[r1],'[cf1]'
drop table [table_name]; |
NULL|disable [t1] 禁用表，删除表和修改表属性都要先禁用表
