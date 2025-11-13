create database dbdistribuidora;
use dbdistribuidora;

create table tbnota_fiscal(
	nf int primary key,
    totalnota decimal(8,2) not null,
    dataemissao date not null
);

create table tbfornecedor(
	codigo int primary key auto_increment,
    nome varchar(200) not null,
    cnpj decimal(14,0) unique,
    telefone decimal(11,0)
);

create table tbproduto(
	codigobarras decimal(14,0) primary key,
    nome varchar(200) not null,
    valorunitario decimal(7,2) not null,
    qtd int null
);

create table tbestado(
	ufid int auto_increment primary key,
    uf char(2) not null
);

create table tbcidade(
	cidadeid int auto_increment primary key,
    cidade varchar(200) not null
);

create table tbbairro(
	bairroid int auto_increment primary key,
    bairro varchar(200) not null
);

create table tbcompra(
	notafiscal int primary key,
    datacompra date not null,
    valortotal decimal(7,2) not null,
    qtdtotal int not null,
    codigo int,
    foreign key (codigo) references tbfornecedor(codigo)
);

create table tbitem_compra(
	notafiscal int,
    codigobarras decimal(14,0),
    qtd int not null,
    valoritem decimal(7,2) not null,
    primary key(codigobarras, notafiscal),
    foreign key (codigobarras) references tbproduto(codigobarras),
    foreign key (notafiscal) references tbcompra(notafiscal)
);

create table tbendereco(
	logradouro varchar(200) not null,
    bairroid int not null,
    cidadeid int not null,
    ufid int not null,
	cep decimal(8,0) primary key,
    foreign key (bairroid) references tbbairro(bairroid),
    foreign key (ufid) references tbestado(ufid),
    foreign key (cidadeid) references tbcidade(cidadeid)
);

create table tbcliente(
	id int auto_increment primary key,
    nomecli varchar(200) not null,
    numend smallint not null,
    compend varchar(50),
    cepcli decimal(8,0),
    foreign key (cepcli) references tbendereco(cep)
);

create table tbvenda(
	numerovenda int primary key,
    datavenda date not null,
    totalvenda decimal(7,2) not null,
    nf int,
    id_cli int not null,
    foreign key (nf) references tbnota_fiscal(nf),
    foreign key (id_cli) references tbcliente(id)
);

create table tbitem_venda(
	qtd int not null,
    valoritem decimal(7,2) not null,
    codigobarras decimal(14),
    numerovenda int,
    primary key(codigobarras, numerovenda),
    foreign key (codigobarras) references tbproduto(codigobarras),
    foreign key (numerovenda) references tbvenda(numerovenda)
);

create table tbcliente_pf(
	id int,
	cpf decimal(11,0) primary key,
    rg decimal(9,0) not null,
    rg_dig char(1) not null,
    nasc date not null,
    foreign key (id) references tbcliente(id)
);

create table tbcliente_pj(
    id int,
	cnpj decimal(14,0) primary key,
    ie decimal(11,0) unique,
    foreign key (id) references tbcliente(id)
);

-- atividade 1

insert into tbfornecedor 
	values
    (null, 'Revenda Chico Loco', 1245678937123, 11934567897),
    (null, 'José Faz Tudo S/A', 1345678937123, 11934567898),
    (null, 'Vadalto Entregas', 1445678937123, 11934567899),
    (null, 'Astrogildo das Estrela', 1545678937123, 11934567800),
    (null, 'Amoroso e Doce', 1645678937123, 11934567801),
    (null, 'Marcelo Dedal', 1745678937123, 11934567802),
    (null, 'Franciscano Cachaça', 1845678937123, 11934567803),
    (null, 'Joãozinho Chupeta', 1945678937123, 11934567804);    

-- atividade 2

delimiter //
create procedure insert_cidade1 ()
begin
	-- Inserindo valores na tbcidade
	insert into tbcidade
		values
		(null, 'Rio de Janeiro'),
		(null, 'São Carlos'),
		(null, 'Campinas'),
		(null, 'Franco da Rocha'),
		(null, 'Osasco'),
		(null, 'Pirituba'),
		(null, 'Lapa'),
		(null, 'Ponta Grossa');
        
end;
// delimiter ;
call insert_cidade1;
-- atividade 3 

delimiter //
create procedure insert_estado1 ()
begin
	-- Inserindo valores na tbestado
	insert into tbestado
		values
		(null, 'SP'),
		(null, 'RJ'),
		(null, 'RS');
        
end;
// delimiter ;
call insert_estado1;

-- atividade 4

delimiter //
create procedure insert_bairro1 ()
begin
	-- Inserindo valores na tbbairro
	insert into tbbairro
		values
		(null, 'Aclimação'),
		(null, 'Capão Redondo'),
		(null, 'Pirituba'),
		(null, 'Liberdade');

end;
// delimiter ;
call insert_bairro1;
    
-- atividade 5

delimiter //
create procedure insert_produto ()
begin
	-- Inserindo valores na tbproduto
	insert into tbproduto
		values
		(12345678910111, 'Rei do Papel Mache', 54.61, 120),
		(12345678910112, 'Bolinha de Sabão', 100.45, 120),
		(12345678910113, 'Carro Bate', 44.00, 120),
		(12345678910114, 'Bola Furada', 10.00, 120),
		(12345678910115, 'Maçã Laranja', 99.44, 120),
		(12345678910116, 'Boneco do Hitler', 124.00, 200),
		(12345678910117, 'Farinha de Suruí', 50.00, 200),
		(12345678910118, 'Zelador do Cemitério', 24.50, 120);

end;
// delimiter ;
call insert_produto;

-- atividade 6

delimiter //
create procedure insert_bairro2 ()
begin
	insert into tbbairro
		values
        (null, 'Lapa'),
        (null, 'Consolação'),
        (null, 'Aclimação'),
        (null, 'Penha'),
        (null, 'Jardim Santa Isabel'),
        (null, 'Sei Lá');
        
end;
// delimiter ;
call insert_bairro2;
        
delimiter //
create procedure insert_cidade2 ()
begin
		insert into tbcidade
		values
        (null, 'São Paulo'),
        (null, 'Barra Mansa'),
        (null, 'Cuiabá'),
        (null, 'Recife');
        
end;
// delimiter ;
call insert_cidade2;

delimiter //
create procedure insert_estado2 ()
begin
		insert into tbestado
		values
        (null, 'MT'),
        (null, 'PE');
        
end;
// delimiter ;
call insert_estado2;

delimiter //
create procedure insert_endereco ()
begin
	-- Inserindo valores na tbendereco

	insert into tbendereco
		values 
		('Rua da Federal',5 , 9, 1, 12345050),
		('Av Brasil',5, 3, 1, 12345051),
		('Rua Liberdade',6, 9, 1, 12345052),
		('Av Paulista',8, 1, 2, 12345053),
		('Rua Ximbú',8, 1, 2, 12345054),
		('Rua Piu XI',8, 3, 1, 12345055),
		('Rua Chocolate',7, 10, 2, 12345056),
		('Rua Pão na Chapa',5, 9, 3, 12345057),
        ('Av Nova',9, 11, 4, 12345058),
		('Rua Veia',9, 11, 4, 12345059),
        ('Rua do Amores',10, 12, 5, 12345060);

end;
// delimiter ;
call insert_endereco;
    
-- atividade 7

delimiter //
create procedure insert_cliente ()
begin
	-- Inserindo valores na tbcliente
	insert into tbcliente (nomecli, numend, compend, cepcli)
		values 
        ('Pimpão', 325, null, 12345051),
        ( 'Disney Chaplin', 89, 'Ap.12', 12345053),
        ('Marciano', 744, null, 12345054),
        ('Lança Perfume', 128, null, 12345059),
        ('Remédio Amargo', 2585, null, 12345058),
        ('Paganada', 159, null, 12345051),
        ('Caloteando', 69, null, 12345053),
        ('SemGrana', 189, null, 12345060),
        ('Cemreais', 5024, 'Sala 23', 12345060),
        ('Durango', 1254, null, 12345060);

end;
// delimiter ;
call insert_cliente;

delimiter //
create procedure insert_clientepf ()
begin
	-- Inserindo valores na tbcliente_pf
	insert into tbcliente_pf
		values	 
        (1, 12345678911, 12345678, 0,'2000-10-12'),
        (2, 12345678912, 12345679, 0, '2001-11-21'),
        (3, 12345678913, 12345680, 0, '2001-01-06'),
        (4, 12345678914, 12345681, 'X', '2004-04-05'),
        (5, 12345678915, 12345682, 0, '2002-07-15');
        
end;
// delimiter ;
call insert_clientepf;

-- atividade 8

delimiter //
create procedure insert_clientepj ()
begin
	-- Inserindo valores na tbcliente_pf
	insert into tbcliente_pj
		values	 
        ( 6, 12345678912345, 98765432198),
        ( 7, 12345678912346, 98765432199),
        ( 8, 12345678912347, 98765432100),
        ( 9, 12345678912348, 98765432101),
        ( 10, 12345678912349, 98765432102);
        
end;
// delimiter ;
call insert_clientepj;

-- atividade 9

delimiter //
create procedure insert_compra()
begin 
	-- Inserindo valores na tabela compra
	insert into tbcompra
		values
        (8459, STR_TO_DATE('2018/05/01', '%Y/%m/%d'), 21944.00, 700, 5),
        (2482, STR_TO_DATE('2020/04/22', '%Y/%m/%d'), 7290.00, 180, 1),
        (21563, STR_TO_DATE('2020/07/12', '%Y/%m/%d'), 900.00, 300, 6),
        (156354, STR_TO_DATE('2021/11/23', '%Y/%m/%d'), 18900.00, 350, 1);
      
end;
// delimiter ;
call insert_compra;

delimiter //
create procedure insert_itemcompra()
begin 
	-- Inserindo valores na tabela item compra
	insert into tbitem_compra
		values
        (8459, 12345678910111, 200, 22.22),
        (2482, 12345678910112, 180, 40.50),
        (21563, 12345678910113, 300, 3.00),
        (8459, 12345678910114, 500, 35.00),
        (156354, 12345678910115, 350, 54.00);
    
end;
// delimiter ;
call insert_itemcompra;

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
delimiter //
create procedure insert_produto2(
	in p_codigobarras decimal(14,0),
    in p_nome varchar(200),
    in p_valorunit decimal(7,2),
    in p_qtd int
)
begin

	insert into tbproduto
		values
        (p_codigobarras, p_nome, p_valorunit, p_qtd);

end;
// delimiter ;
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

-- atividade 16

create table tbproduto_historico like tbproduto;

-- atividade 17

alter table tbproduto_historico 
	add column Ocorrencia varchar(20) null, 
    add column Atualizacao datetime null;