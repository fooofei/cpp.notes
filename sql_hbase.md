

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
