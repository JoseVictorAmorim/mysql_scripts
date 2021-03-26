use hcode;
DELIMITER $$

create function fn_imposto_renda(pvlsalario dec(10,2)) returns dec(10,2)
begin

    declare vimposto dec(10,2);
    
    set vimposto = case
        when pvlsalario <= 1903.98 then 0
        when pvlsalario >= 1903.99 and pvlsalario <= 2826.65 then (pvlsalario * .075) - 142.80
        when pvlsalario >= 2826.66 and pvlsalario <= 3751.05 then (pvlsalario * .15) - 354.80
        when pvlsalario >= 3751.06 and pvlsalario <= 4664.68 then (pvlsalario * .225) - 636.13
        when pvlsalario >= 4664.69 then(pvlsalario * .275) - 869.36
    end;
    
    return vimposto;
        
end $$

DELIMITER ;

select * from tb_funcionarios;

select *, fn_imposto_renda(a.vlsalario) as imposto from tb_funcionarios a inner join tb_pessoas using(idpessoa);