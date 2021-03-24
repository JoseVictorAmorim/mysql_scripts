select * from tb_pessoas;
select * from tb_funcionarios;

insert into tb_pessoas values(1, 'Joao', 'M');

insert into tb_pessoas (nome, sexo) values ('Maria', 'F');

insert into tb_pessoas (nome, sexo) values
('Divanei', 'M'),
('Luiz', 'M'),
('Djalma', 'M'),
('Nataly', 'F'),
('Tatiane', 'F'),
('Cristiane', 'F'),
('Jaqueline', 'F');	

insert into tb_funcionarios
select id, nome, 1000, current_date(), sexo, null from tb_pessoas;
