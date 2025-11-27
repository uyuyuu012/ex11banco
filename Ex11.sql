create database dbDistribuidora;
use dbDistribuidora;

create table tbFornecedor(
	Codigo int primary key auto_increment,
    Nome varchar(200) not null,
    CNPJ decimal(14,0) unique,
    Telefone decimal(11,0)
);

create table tbProduto(
	CodigoBarras decimal(14,0) primary key,
    Nome varchar(200) not null,
    Valor decimal(7,2) not null,
    Qtd int null
);

create table tbEstado(
	UFId int auto_increment primary key,
    UF char(2) not null
);

create table tbCidade(
	CidadeId int auto_increment primary key,
    Cidade varchar(200) not null
);

create table tbBairro(
	BairroId int auto_increment primary key,
    Bairro varchar(200) not null
);

create table tbCompra(
	NotaFiscal int primary key,
    DataCompra date not null,
    ValorTotal decimal(7,2) not null,
    QtdTotal int not null,
    Codigo int,
    foreign key (Codigo) references tbFornecedor(Codigo)
);

create table tbItem_compra(
	NotaFiscal int not null,
    CodigoBarras decimal(14,0) not null,
    Qtd int not null,
    ValorItem decimal(7,2) not null,
    primary key(CodigoBarras, NotaFiscal),
    foreign key (CodigoBarras) references tbProduto(CodigoBarras),
    foreign key (NotaFiscal) references tbCompra(NotaFiscal)
);

create table tbEndereco(
	Logradouro varchar(200) not null,
    
    BairroId int not null,
    foreign key (BairroId) references tbBairro(BairroId),
    
    CidadeId int not null,
    foreign key (CidadeId) references tbCidade(CidadeId),
    
    UFId int not null,
    foreign key (UFId) references tbEstado(UFId),
    
	CEP decimal(8,0) primary key
);

create table tbCliente(
	Id int auto_increment primary key,
    NomeCli varchar(200) not null,
    NumEnd int not null,
    CompEnd varchar(50),
    CepCli decimal(8,0),
    foreign key (CepCli) references tbEndereco(CEP)
);

create table tbNota_fiscal(
	NF int primary key,
    totalnota decimal(8,2) not null,
    dataemissao date not null
);

create table tbVenda(
	NumeroVenda int primary key,
    DataVenda date not null,
    TotalVenda decimal(7,2) not null,
    NF int,
    Id_Cli int not null,
    foreign key (NF) references tbNota_Fiscal(NF),
    foreign key (Id_Cli) references tbCliente(Id)
);

create table tbItem_venda(
	qtd int not null,
    valoritem decimal(7,2) not null,
    codigobarras decimal(14),
    numerovenda int,
    primary key(codigobarras, numerovenda),
    foreign key (codigobarras) references tbProduto(CodigoBarras),
    foreign key (numerovenda) references tbVenda(NumeroVenda)
);

create table tbCliente_PF(
	Id int not null,
	CPF decimal(11,0) primary key,
    RG decimal(9,0) not null,
    RG_DIG char(1) not null,
    Nasc datetime not null,
    foreign key (Id) references tbCliente(Id)
);

create table tbCliente_PJ(
    Id int not null,
	CNPJ decimal(14,0) primary key,
    IE decimal(11,0) unique,
    foreign key (Id) references tbCliente(Id)
);

insert into tbFornecedor(Nome, CNPJ, Telefone )
	values
    ('Revenda Chico Loco', 1245678937123, 11934567897),
    ('José Faz Tudo S/A', 1345678937123, 11934567898),
    ('Vadalto Entregas', 1445678937123, 11934567899),
    ('Astrogildo das Estrela', 1545678937123, 11934567800),
    ('Amoroso e Doce', 1645678937123, 11934567801),
    ('Marcelo Dedal', 1745678937123, 11934567802),
    ('Franciscano Cachaça', 1845678937123, 11934567803),
    ('Joãozinho Chupeta', 1945678937123, 11934567804);    

-- atividade 2

delimiter $$
create procedure insert_cidade1(in InCidade varchar(200))
begin
	-- Inserindo valores na tbcidade
	insert into tbCidade(Cidade)
		values
        (InCidade);
        
end;
$$ delimiter ;

call insert_cidade1('Rio de Janeiro');
call insert_cidade1('São Carlos');
call insert_cidade1('Campinas');
call insert_cidade1('Franco da Rocha');
call insert_cidade1('Osasco');
call insert_cidade1('Pirituba');
call insert_cidade1('Lapa');
call insert_cidade1('Ponta Grossa');

-- atividade 3 

delimiter $$
create procedure insert_estado1(in InUF varchar(2))
begin
	-- Inserindo valores na tbestado
	insert into tbEstado(UF)
		values
        (InUF);

end;
$$ delimiter ;
call insert_estado1('SP');
call insert_estado1('RJ');
call insert_estado1('RS');

select * from tbEstado;

-- atividade 4

delimiter $$
create procedure insert_bairro1 (in InBairro varchar(200) )
begin
		insert into tbBairro(Bairro)
		values
        (InBairro);
end;

$$ delimiter ;
call insert_bairro1('Aclimação');
call insert_bairro1('Capão Redondo');
call insert_bairro1('Pirituba');
call insert_bairro1('Liberdade');

select * from tbBairro;

-- atividade 5

delimiter $$
create procedure insert_produto (in InCodigo bigint, in InNome varchar(200), in InValor decimal(7,2), in InQuantidade int)
begin
	-- Inserindo valores na tbproduto
		insert into tbProduto
		values
		(InCodigo, InNome,InValor,InQuantidade);
end;
$$ delimiter ;

call insert_produto (12345678910111, 'Rei do Papel Mache', 54.61, 120);
call insert_produto (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call insert_produto (12345678910113, 'Carro Bate', 44.00, 120);
call insert_produto (12345678910114, 'Bola Furada', 10.00, 120);
call insert_produto (12345678910115, 'Maçã Laranja', 99.44, 120);
call insert_produto (12345678910116, 'Boneco do Hitler', 124.00, 200);
call insert_produto (12345678910117, 'Farinha de Suruí', 50.00, 200);
call insert_produto (12345678910118, 'Zelador do Cemitério', 24.50, 120);

select * from tbProduto


-- atividade 6



    delimiter $$
create procedure insert_endereco (in InLogradouro varchar(200), in InBairro varchar(200), in InCidade varchar(200), in InUf varchar(2), in InCep int)
begin
	-- Inserindo valores na tbendereco
	
	insert into tbBairro(Bairro)
		values
        (InBairro);
        
	insert into tbCidade(Cidade)
		values
        (InCidade);
        
	insert into tbEstado(UF)
		values
        (InUF);
        
	insert into tbEndereco(Logradouro, CEP)
		values 
		(InLogradouro, InCep);
end;
$$ delimiter ;

call insert_endereco('Rua da Federal','Lapa' , 'São Paulo', 'SP', 12345050);
call insert_endereco('Av Brasil','Lapa', 'Campinas', 'SP', 12345051);
call insert_endereco('Rua Liberdade','Consolação', 'São Paulo', 'SP', 12345052);
call insert_endereco('Av Paulista','Penha', 'Rio de Janeiro', 'RJ', 12345053);
call insert_endereco('Rua Ximbú','Penha', 'Rio de Janeiro', 'RJ', 12345054);
call insert_endereco('Rua Piu XI','Penha', 'Campinas', 'SP', 12345055);
call insert_endereco('Rua Chocolate','Aclimação', 'Barra Mansa', 'RJ', 12345056);
call insert_endereco('Rua Pão na Chapa','Barra Funda', 'Ponta Grossa', 'RS', 12345057);

-- atividade 7
 

delimiter $$
create procedure insert_cliente (in InNomeCli varchar(200), in InNumEnd int, in InCompEnd varchar(200), in InCepCli int, in InId int, in InCPF decimal(11,0), in InRG decimal(9,0), in InRG_DIG char(1), in InNasc datetime)
begin

		insert into tbCliente (NomeCli, NumEnd, CompEnd, CepCli)
		values 
        (InNomeCli, InNumEnd, InCompEnd, InCepCli);
	

	insert into tbCliente_PF(Id, CPF, RG, RG_DIG, Nasc)
		values	 
			(InId, InCPF, InRG, InRG_DIG, InNasc);
end;
$$ delimiter ;

call insert_cliente('Pimpão', 325, null, 12345051, 1, 12345678911, 12345678, 0,'2000-10-12');
call insert_cliente('Disney Chaplin', 89, 'Ap.12', 12345053, 2, 12345678912, 12345679, 0, '2001-11-21');
call insert_cliente('Marciano', 744, null, 12345054, 3, 12345678913, 12345680, 0, '2001-01-06');
call insert_cliente('Lança Perfume', 128, null, 12345059, 4, 12345678914, 12345681, 'X', '2004-04-05');
call insert_cliente('Remédio Amargo', 2585, null, 12345058, 5, 12345678915, 12345682, 0, '2002-07-15');

select * from tbCliente;

-- atividade 8

DELIMITER $$
create procedure insert_clientepj (IN inCNPJ BIGINT, IN inIE BIGINT, IN inCep INT, IN inLogradouro VARCHAR(200), IN inNumEnd INT, IN inCompEnd VARCHAR(50), IN inBairro VARCHAR(200), IN inCidade VARCHAR(200), IN inUF VARCHAR(2))
BEGIN
    INSERT INTO tbCliente_PJ (CNPJ, IE)
    VALUES (inCNPJ, inIE);

    INSERT INTO tbEndereco (Logradouro, Bairro, Cidade, UF)
    VALUES (inLogradouro, inBairro, inCidade, inUF);
END
$$ DELIMITER ;

CALL insert_clientepj(12345678912345,98765432198,0,'Av Brasil',0,NULL,'Lapa','Campinas','SP');
CALL insert_clientepj(12345678912346,98765432199,0,'Av Paulista' ,0,NULL,'Penha','Rio de Janeiro','RJ');
CALL insert_clientepj(12345678912347,98765432100,0,'Rua dos Amores',0,NULL,'Sei Lá','Recife','PE');
CALL insert_clientepj(12345678912348,98765432101,0,'Rua dos Amores',0,NULL,'Sei Lá','Recife','PE');
CALL insert_clientepj(12345678912349,98765432102,0,'Rua dos Amores',0,NULL,'Sei Lá','Recife','PE');

select * from tbCliente_PJ;

-- atividade 9

DELIMITER $$
CREATE PROCEDURE insert_compra(IN inNotaFiscal INT,IN inFornecedor VARCHAR(200),IN inDataCompra DATE,IN inCodigoBarras BIGINT,IN inValorItem DECIMAL(10,2),IN inQtd INT,IN inQtdTotal INT,IN inValorTotal DECIMAL(12,2))
BEGIN
    INSERT INTO tbCompra(NotaFiscal, Fornecedor, DataCompra, CodigoBarras, ValorItem, Qtd, QtdTotal, ValorTotal)
    VALUES (inNotaFiscal, inFornecedor, inDataCompra, inCodigoBarras, inValorItem, inQtd, inQtdTotal, inValorTotal);
END$$
DELIMITER ;
CALL insert_compra(8459, 'Amoroso e Doce', STR_TO_DATE('2018/05/01', '%Y/%m/%d'), 12345678910111, 22.22, 200, 700, 21944.00);
CALL insert_compra(2482, 'Revenda Chico Loco', STR_TO_DATE('2020/04/22', '%Y/%m/%d'), 12345678910112, 40.50, 180, 180, 7290.00);
CALL insert_compra(21563, 'Marcelo Dedal', STR_TO_DATE('2020/07/12', '%Y/%m/%d'), 12345678910113, 3.00, 300, 300, 900.00);
CALL insert_compra(8459, 'Amoroso e Doce', STR_TO_DATE('2018/05/01', '%Y/%m/%d'), 12345678910114, 35.00, 500, 700, 21944.00);
CALL insert_compra(156354, 'Revenda Chico Loco', STR_TO_DATE('2021/11/23', '%Y/%m/%d'), 12345678910115, 54.00, 350, 350, 18900.00);

select * from tbCompra;



-- atividade 10

delimiter //
create procedure insert_vendas(
	in p_id_cli int,
    in p_codigobarras decimal(14,0),
    in p_qtd int,
    in p_numerovenda int,
    in p_nf int
)
begin 
-- inserindo valor na tabela venda
	declare	v_id_cli_exist int;
    declare v_codigobarras_exist decimal(14,0);
    declare v_valoritem decimal(7,2);
    
    select COUNT(*) into v_id_cli_exist
    from tbcliente
    where id = p_id_cli;
    
    select COUNT(*) into v_codigobarras_exist
    from tbproduto
    where codigobarras = p_codigobarras;
    
    select codigobarras, valorunitario into v_codigobarras_exist, v_valoritem
    from tbproduto
    where codigobarras = p_codigobarras
    limit 1;
    
	if v_id_cli_exist > 0 and v_codigobarras_exist > 0 then
        insert into tbvenda
			values 
            (p_numerovenda, current_date(), v_valoritem * p_qtd , p_nf, p_id_cli);
		insert into tbitem_venda
			values 
            (p_qtd, v_valoritem, p_codigobarras, p_numerovenda);
	else
		do null;
    end if;
    
end; 
// delimiter ;
call insert_vendas(1, 12345678910111, 1, 1, null);
call insert_vendas(4, 12345678910112, 2, 2, null);
call insert_vendas(1, 12345678910113, 1, 3, null);

-- atividade 11

-- inserindo dados na tbnota_fiscal
delimiter //
create procedure insert_nf(
	in p_nf int,
    in p_id_cli int
)
begin
	declare v_qtd_pedido int default 0;
    declare v_totalnf decimal (7,2) default 0.00;
    
    select count(*), coalesce(sum(totalvenda), 0)
    into v_qtd_pedido, v_totalnf
    from tbvenda
    where id_cli = p_id_cli;
    
    if v_qtd_pedido > 0 then
		insert into tbnota_fiscal
			values
            (p_nf , v_totalnf, current_date());
	else
		do null;
	end if;
    
end;
// delimiter ;
call insert_nf(359, 1);
call insert_nf(360, 4);

-- atividade 12

-- inserindo novos produtos na tbproduto
delimiter $$
create procedure insert_Produto2(	in p_codigobarras decimal(14,0),    in p_nome varchar(200),    in p_valorunit decimal(7,2),    in p_qtd int)
begin
	insert into tbProduto
		values
        (p_codigobarras, p_nome, p_valorunit, p_qtd);
end;
$$ delimiter ;
call insert_produto2(12345678910130, 'Camiseta de Poliéster', 35.61, 100);
call insert_produto2(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call insert_produto2(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

-- atividade 13

-- deletando valores na tabela produto
delimiter //
create procedure delete_produto(
	in p_codigobarras decimal(14,0)
)
begin
	
    delete from tbproduto where codigobarras = p_codigobarras;
    
end;
// delimiter ;
call delete_produto(12345678910116);
call delete_produto(12345678910117);

-- atividade 14

-- atualizando valor unitario dos produtos na tbproduto
delimiter // 
create procedure update_produto(
	in p_codigobarras decimal(14,0),
    in p_valor decimal(7,2)
)
begin

	update tbproduto
    set valorunitario = p_valor
    where codigobarras = p_codigobarras;
    
end;
// delimiter ;
call update_produto(12345678910111, 64.50);
call update_produto(12345678910112, 120.50);
call update_produto(12345678910113, 64.00);

-- atividade 15

-- selecionando tbproduto para amostra
delimiter //
create procedure select_produto()
begin
	
	select * from tbproduto;
    
end;
// delimiter ;
call select_produto();

    

    
