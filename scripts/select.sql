select * from tb_pessoas;

select count(*) from tb_pessoas;
select count(*) as totalReg from tb_pessoas;

select nome, salario as atual, convert(salario*1.1, dec(10,2)) as '10%' from tb_funcionarios;


select * from tb_funcionarios where sexo = 'm' and salario > 1000;

select * from tb_funcionarios where sexo = 'f' or salario > 1000;

update tb_funcionarios set salario = salario * 1.4 where id = 4;
