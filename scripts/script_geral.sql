create database hcode;
use hcode;
create table tb_pessoas(
    id int,
    nome varchar(100),
    sexo enum('M','F')
);

insert into tb_pessoas values(1, 'Joao', 'M');
insert into tb_pessoas (nome, sexo) values
('Carlos', 'M'),
('Jorge', 'M'),
('Cleber', 'M'),
('Maria', 'F'),
('Carla', 'F'),
('Livia', 'F'),
('Alice', 'F'),
('Lara', 'F');

create table tb_funcionarios(
    id int,
    nome varchar(1000),
    sexo enum('M','F'),
    salario decimal(10,2),
    admissao date,
    hcadstro timestamp default current_timestamp()
);

insert into tb_funcionarios select id, nome, sexo, 1000, current_date(), NULL from tb_pessoas;

select * from tb_funcionarios;
update tb_funcionarios set salario = salario * 1.4 where id = 7;

select * from tb_funcionarios where sexo = 'M' or salario > 1000;

select * from tb_funcionarios where nome like '%l%';
select * from tb_funcionarios where nome like 'l%';
select * from tb_funcionarios where nome like 'l%';
select * from tb_funcionarios where nome like '%a';
select * from tb_funcionarios where nome not like 'l%';


select * from tb_funcionarios where salario between 1050 and 2000;
select * from tb_funcionarios where salario not between 1050 and 2000;

select * from tb_funcionarios where soundex(nome) = soundex('carlo');


select * from tb_funcionarios where hcadstro > '2016-01-01';
update tb_funcionarios set admissao = '2021-03-22' where id = 1;
update tb_funcionarios set admissao = '2021-03-21' where id = 2;
update tb_funcionarios set admissao = date_add(current_date(), interval 60 day) where id = 2;   

select datediff(admissao, current_date()) as diferenca_dias from tb_funcionarios where id = 2;

select * from tb_funcionarios where month(admissao) = 3;


select * from tb_funcionarios order by nome;

select * from tb_funcionarios order by salario;
select * from tb_funcionarios order by salario desc;

select * from tb_funcionarios order by salario desc, nome;

select * from tb_funcionarios order by salario limit 3;

-- UPDATE
update tb_funcionarios set salario = 3000 where id = 5;
update tb_funcionarios set salario = 4000, admissao = '2020-12-12' where id = 8;
select * from tb_funcionarios where id = 5 or id = 8;

-- DELETE

delete from tb_funcionarios where id = 1;



start transaction;

delete from tb_pessoas where id > 0 and id < 10;
select * from tb_pessoas;

rollback;
commit;

insert into tb_pessoas values (NULL, 'Jose', 'M');

truncate table tb_pessoas;

drop table tb_funcionarios;
drop table tb_pessoas;

-- Costraints
create table tb_pessoas(
    idpessoa INT auto_increment not null,
    desnome varchar(256) not null,
    dtcadastro timestamp not null default current_timestamp(),
    constraint pk_pessoas primary key (idpessoa)
) engine = innoDB;

create table tb_funcionarios(
    idfuncionario int auto_increment not null,
    idpessoa int not null,
    vlsalario decimal(10,2) not null default 1000.00,
    dtadmissao date not null,
    
    constraint pk_funcionarios primary key(idfuncionario),
    constraint fk_funcionarios_pessoas foreign key (idpessoa)
        references tb_pessoas (idpessoa)
);


insert into tb_pessoas (desnome) values ('Joao');
select * from tb_pessoas;


insert into tb_funcionarios values(null, 1, 5000, current_date());
select * from tb_funcionarios;
select * from tb_pessoas;

delete from tb_pessoas where idpessoa = 3;

insert into tb_funcionarios values(null, 2, 5000, current_date());

-- JOIN

select * from tb_funcionarios a inner join tb_pessoas b on a.idpessoa = b.idpessoa;

select * from tb_funcionarios inner join tb_pessoas using(idpessoa);

insert into tb_pessoas values (null, 'Glaucio', null);


select * from tb_pessoas a left join tb_funcionarios b on a.idpessoa = b.idpessoa; 
select * from tb_pessoas a right join tb_funcionarios b on a.idpessoa = b.idpessoa; 


-- subqueries;
    
insert into tb_pessoas values (null, 'Jose', null);

update tb_pessoas set idpessoa = 3 where desnome = 'Jose';
    
select idpessoa from tb_pessoas where desnome like 'j%';

delete from tb_pessoas where idpessoa in(select idpessoa from tb_pessoas where desnome like 'j%');

-- group by

create table tb_pedidos(
    idpedido INT auto_increment not null,
    idpessoa int not null,
    dtpedido datetime not null,
    vlpedido dec(10,2),
    
    constraint pk_pedidos primary key (idpedido),
    
    constraint fk_pedidos_pessoas foreign key (idpessoa)
        references tb_pessoas(idpessoa)
);


select * from tb_pessoas;
select * from tb_pedidos;



insert into tb_pedidos values (null, 1, current_date(), 22000.00);
insert into tb_pedidos values (null, 1, current_date(), 5000.00);
insert into tb_pedidos values (null, 1, current_date(), 10000.00);
insert into tb_pedidos values (null, 1, current_date(), 1000.00);
insert into tb_pedidos values (null, 1, current_date(), 3000.00);


insert into tb_pedidos values (null, 2, current_date(), 1999.90);
insert into tb_pedidos values (null, 2, current_date(), 2000.00);
insert into tb_pedidos values (null, 2, current_date(), 123.405);

insert into tb_pedidos values (null, 4, current_date(), 40000.00);


select b.desnome, sum(a.vlpedido) as total from tb_pedidos a inner join tb_pessoas b using(idpessoa) group by b.idpessoa;
select b.desnome, sum(a.vlpedido) as total, convert(avg(a.vlpedido), dec(10,2)) as media 
from tb_pedidos a inner join tb_pessoas b using(idpessoa) group by b.idpessoa;

select b.desnome, sum(a.vlpedido) as total, convert(avg(a.vlpedido), dec(10,2)) as media,
convert(min(a.vlpedido), dec(10,2)) as menorValor, convert(max(a.vlpedido), dec(10,2)) as maiorValor, count(*) as 'TotalPedidos'
from tb_pedidos a inner join tb_pessoas b using(idpessoa) group by b.idpessoa;

select b.desnome, sum(a.vlpedido) as total, convert(avg(a.vlpedido), dec(10,2)) as media,
convert(min(a.vlpedido), dec(10,2)) as menorValor, convert(max(a.vlpedido), dec(10,2)) as maiorValor, count(*) as 'TotalPedidos'
from tb_pedidos a inner join tb_pessoas b using(idpessoa) group by b.idpessoa having sum(a.vlpedido) > 5000 order by sum(vlpedido);


create view v_pedidostotais
as
select b.desnome, sum(a.vlpedido) as total, convert(avg(a.vlpedido), dec(10,2)) as media,
convert(min(a.vlpedido), dec(10,2)) as menorValor, convert(max(a.vlpedido), dec(10,2)) as maiorValor, count(*) as 'TotalPedidos'
from tb_pedidos a inner join tb_pessoas b using(idpessoa) group by b.idpessoa;


select