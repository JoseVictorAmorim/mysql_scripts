delimiter $$

create procedure sp_funcionario_save(
pdesnome varchar(256), 
pvlsalario dec(10,2), 
pdtadmissao datetime
)
begin
    declare vidpessoa int;
    
    start transaction;
    
    if not exists(select idpessoa from tb_pessoas where desnome = pdesnome) then 
        insert into tb_pessoas values (null, pdesnome, null);
        set vidpessoa = last_insert_id();
    else
        select "Usuário já cadastrado na tabela de pessoas" as resultado;
        rollback;
        
    end if;
    
     if not exists(select idpessoa from tb_funcionarios where idpessoa = vidpessoa) then 
        insert into tb_funcionarios values (null, vidpessoa, pvlsalario, pdtadmissao);
    else
        select "Usuário já cadastrado na tabela de funcionários" as resultado;
        rollback;
        
    end if;
    
    commit;
    
    select "Dados Cadastrados com sucesso!" as resultado;

end$$

delimiter ;


call sp_funcionario_save('Joao', 500000, current_date());
call sp_funcionario_save('Divanei', 500000, current_date());

select * from tb_pessoas;
select * from tb_funcionarios;