delimiter $$

create procedure sp_pessoa_save(
pdesnome varchar(256)
)

BEGIN
    insert into tb_pessoas value (null, pdesnome, null);
    
    select * from tb_pessoas where idpessoa = last_insert_id();
    
END$$

delimiter ;

call sp_pessoa_save('Massarraro');