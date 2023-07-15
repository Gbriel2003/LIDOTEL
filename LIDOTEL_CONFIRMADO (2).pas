{*Paola Marquez
 *Gabriel Cardona}

program hotelLidotel;
uses crt, SysUtils;

//CREAMOS TRES REGISTROS DIFERENTES PARA CADA OPCION
type
	TClienteIndividual = record
	nombre: string;
	apellido: string;
	cedula: string;
	email: string;
	telefono: string;
	edad: string;
end;

	TClienteAcompanado = record
	nombre: string;
	apellido: string;
	cedula: string;
	email: string;
	telefono: string;
	edad: string;
end;

	TGrupoFamilia = record
	nombre: string;
	apellido: string;
	cedula: string;
	email: string;
	telefono: string;
	edad: string;
end;

var	
	clienteIndividual: TClienteIndividual;
	archivoClienteIndividual: textfile;
	
	clienteAcompanado: TClienteAcompanado;
	archivoClienteAcompanado: textfile;
	
	clienteGrupoFamilia: TGrupoFamilia;
	archivoGrupoFamilia: textfile;
	
	cantPersonas1, cantPersonas2, cantPersonas3: integer;
	i, op, totalGrupo: integer;
	adultos, ninos: integer;
	pago, cambio: integer;
	editarDatos: boolean;
	descripcion: string;
	habitacion: integer;
	cantDias: integer;
	resp: string;

//CREAMOS PROCEDIMIENTO PARA EL COBRO DE LAS HABITACIONES

procedure procesoCobro();
begin {INICIO DEL PROCEDIMIENTO DE COBRO}
	if pago > habitacion then
	begin
		cambio := pago - habitacion;
		
		textcolor(white);
		writeln('||******************************||');
		writeln('||Por favor, espere su cambio...||');
		writeln('||******************************||');
		delay(5000); {INCLUIMOS LA OPCION "DELAY" PARA QUE AL PROCESAR EL CAMBIO, EL PROGRAMA ESPERE 5 SEGUNDOS ANTES DE MOSTRAR EL SIGUIENTE MENSAJE.}
		
		write('||Su cambio es de: ');
		textcolor(green);
		writeln('------------');
		writeln(cambio, '$');
		textcolor(white);
		writeln('||******************************||');
	end
	
	else if pago < habitacion then
	begin
		repeat
			begin
				textcolor(white);
				writeln('||*******************************************||');
				write('||Su pago esta incompleto, tiene un faltante de: ');
				textcolor(green);
				writeln(habitacion-pago, '$');
				
				textcolor(white);
				writeln('||******************************||');
				write('||Su pago completo seria de: ');
				textcolor(green);
				writeln('-------------');
				writeln(habitacion, '$');
				
				textcolor(white);
				writeln('||------------------------------||');
				write('||Por favor, ingrese su dinero: ');
				textcolor(green);
				readln(pago);
				textcolor(white);
				writeln('||******************************||');
			end;
		until pago >= habitacion;
	end;
end; {FIN DEL PROCEDIMIENTO DE COBRO}

//PROCEDIMIENTO PARA MOSTRAR LA FACTURA DEL CLIENTE 

procedure MostrarFacturaIndividual();
begin {INICIO DEL PROCEDIMIENTO MOSTRAR FACTURA}
	textcolor(lightgreen);
	writeln('||*********************************************************||');
	writeln('||                          FACTURA                        ||');
	writeln('||*********************************************************||');
	writeln('|| EMPRESA: Lidotel Boutique             FECHA: 00/00/0000 ||');
	writeln('|| DIRECCION: C.C Sambil Margarita                         ||');
	writeln('||*********************************************************||');
	writeln('||  Nombre: ', (clienteIndividual.nombre));
	writeln('||  Apellido: ', (clienteIndividual.apellido));
	writeln('||  Cedula: ', (clienteIndividual.cedula));
	writeln('||  E-mail: ', (clienteIndividual.email));
	writeln('||  Telefono: ', (clienteIndividual.telefono));
	writeln('||  Dias de estadia: ', cantDias);
	writeln('||  Habitacion: ', descripcion);
	writeln('||=========================================================||');
	writeln('||                                 TOTAL A PAGAR->  ', habitacion, '$');
	writeln('||*********************************************************||');
end; {FIN DEL PROCEDIMIENTO MOSTRAR FACTURA}

////////////////////////////////////////////////////////////////////////

procedure MostrarFacturaAcompanado();
begin {INICIO DEL PROCEDIMIENTO MOSTRAR FACTURA}
	textcolor(lightgreen);
	writeln('||*********************************************************||');
	writeln('||                          FACTURA                        ||');
	writeln('||*********************************************************||');
	writeln('|| EMPRESA: Lidotel Boutique             FECHA: 00/00/0000 ||');
	writeln('|| DIRECCION: C.C Sambil Margarita                         ||');
	writeln('||*********************************************************||');
	writeln('||  Nombre: ', (clienteAcompanado.nombre));
	writeln('||  Apellido: ', (clienteAcompanado.apellido));
	writeln('||  Cedula: ', (clienteAcompanado.cedula));
	writeln('||  E-mail: ', (clienteAcompanado.email));
	writeln('||  Telefono: ', (clienteAcompanado.telefono));
	writeln('||  Dias de estadia: ', cantDias);
	writeln('||  Habitacion: ', descripcion);
	writeln('||=========================================================||');
	writeln('||                                 TOTAL A PAGAR->  ', habitacion, '$');
	writeln('||*********************************************************||');
end; {FIN DEL PROCEDIMIENTO MOSTRAR FACTURA}

////////////////////////////////////////////////////////////////////////

procedure MostrarFacturaGrupo_Familia();
begin {INICIO DEL PROCEDIMIENTO MOSTRAR FACTURA}
	textcolor(lightgreen);
	writeln('||*********************************************************||');
	writeln('||                          FACTURA                        ||');
	writeln('||*********************************************************||');
	writeln('|| EMPRESA: Lidotel Boutique             FECHA: 00/00/0000 ||');
	writeln('|| DIRECCION: C.C Sambil Margarita                         ||');
	writeln('||*********************************************************||');
	writeln('||  Nombre: ', (clienteGrupoFamilia.nombre));
	writeln('||  Apellido: ', (clienteGrupoFamilia.apellido));
	writeln('||  Cedula: ', (clienteGrupoFamilia.cedula));
	writeln('||  E-mail: ', (clienteGrupoFamilia.email));
	writeln('||  Telefono: ', (clienteGrupoFamilia.telefono));
	writeln('||  Dias de estadia: ', cantDias);
	writeln('||  Habitacion: ', descripcion);
	writeln('||=========================================================||');
	writeln('||                                 TOTAL A PAGAR->  ', habitacion, '$');
	writeln('||*********************************************************||');
end; {FIN DEL PROCEDIMIENTO MOSTRAR FACTURA}

//PROCEDIMIENTO PARA PEDIR DATOS AL USUARIO EN EL REGISTRO INDIVIDUAL

procedure registroIndividual();
var
		cedulaExistente: boolean;
		linea: string;
BEGIN {INICIO DEL PROCEDIMIENTO REGISTRO-INDIVIDUAL}
	if cantPersonas1 < 2000 then
	
	begin {inicio if}
		cantPersonas1 := cantPersonas1 + 1;
		cedulaExistente := false;
		
		{inicializamos el archivo}
		
		assign(archivoClienteIndividual, 'clienteIndividual.dat');
		
		{Creamos archivo si no existe}
		
		if not FileExists('clienteIndividual.dat') then
		Rewrite(archivoClienteIndividual);
		
		textcolor(yellow);
		writeln('||....................................................................||');
		writeln('||Por favor, indique los siguientes datos para su proceso de registro ||');
		writeln('||....................................................................||');

		repeat
			textcolor(white);
			writeln('||......................................................||');
			write('|| Nombre: ');
			readln(clienteIndividual.nombre);
		until clienteIndividual.nombre <> '';
		
		repeat
			writeln('||......................................................||');
			write('|| Apellido: ');
			readln(clienteIndividual.apellido);
		until clienteIndividual.apellido <> '';
		
		repeat
			writeln('||......................................................||');
			write('|| Numero de cedula: ');
			readln(clienteIndividual.cedula);
		until clienteIndividual.cedula <> '';

		repeat
			writeln('||......................................................||');
			write('|| E-mail: ');
			readln(clienteIndividual.email);
		until clienteIndividual.email <> '';

		repeat
			writeln('||......................................................||');
			write('|| Numero de telefono: ');
			readln(clienteIndividual.telefono);
		until clienteIndividual.telefono <> '';
	end; {fin if}
	
		//VERIFICAMOS SI LA CEDULA YA FUE REGISTRADA
		
		reset(archivoClienteIndividual);

		while not EOF(archivoClienteIndividual) do
			begin {inicio verificar si cedula existe}
				read(archivoClienteIndividual, linea);
				if Pos(clienteIndividual.cedula, linea) > 0 then
				begin
					cedulaExistente := true;
					break;
				end;
			end; {fin verificar si cedula existe}
		
		if cedulaExistente = true then
		begin
			writeln('|| El cliente ya se encuentra registrado. ||');
		end; 
		
		Close(archivoClienteIndividual);

END; {FIN DEL PROCEDIMIENTO REGISTRO-INDIVIDUAL}

//PROCEDIMIENTO PARA PEDIR DATOS AL USUARIO EN EL REGISTRO ACOMPANADO

procedure registroAcompanado();
var
	cedulaExistente: boolean;
	linea: string;
	
BEGIN {INICIO DEL PROCEDIMIENTO REGISTRO-ACOMPANADO}
	if cantPersonas2 < 2000 then
	begin {inicio if}
		clrscr;
		cantPersonas2 := cantPersonas2 + 1;
		cedulaExistente := false;
	
		{Inicializamos el archivo}
		
		assign(archivoClienteAcompanado, 'clienteAcompanado.dat');
		
		{Creamos archivo si no existe}
		
		if not FileExists('clienteAcompanado.dat') then
		Rewrite(archivoClienteAcompanado);
		
		textcolor(yellow);
		writeln('||............................................................................||');
		writeln('||     Por favor, indique los siguientes datos para su proceso de registro    ||');
		writeln('||............................................................................||');

		repeat
			textcolor(white);
			writeln('||............................................................................||');
			write('|| Nombre: ');
			readln(clienteAcompanado.nombre);
		until clienteAcompanado.nombre <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Apellido: ');
			readln(clienteAcompanado.apellido);
		until clienteAcompanado.apellido <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Numero de cedula: ');
			readln(clienteAcompanado.cedula);
		until clienteAcompanado.cedula <> '';

		repeat
			writeln('||............................................................................||');
			write('|| E-mail: ');
			readln(clienteAcompanado.email);
		until clienteAcompanado.email <> '';

		repeat
			writeln('||............................................................................||');
			write('|| Numero de telefono: ');
			readln(clienteAcompanado.telefono);
		until clienteAcompanado.telefono <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Edad: ');
			readln(clienteAcompanado.edad);
		until clienteAcompanado.edad <> '';
		
			//VERIFICAMOS SI LA CEDULA YA FUE REGISTRADA
			
			reset(archivoClienteAcompanado);

			while not EOF(archivoClienteAcompanado) do
				begin {inicio verificar si cedula existe}
					read(archivoClienteAcompanado, linea);
					if Pos(clienteAcompanado.cedula, linea) > 0 then
					begin
						cedulaExistente := true;
						break;
					end;
				end; {fin verificar si cedula existe}
			
			if cedulaExistente = true then
			begin
				writeln('|| El cliente ya se encuentra registrado. ||');
			end;

		//REPETIMOS EL PROCESO DE PEDIR LOS DATOS PARA EL ACOMPANANTE
		
		begin {INICIO DE REPETIR LOS DATOS}
			clrscr;
			writeln('||............................................................................||');
			writeln('||      Por favor, indique los datos para el registro de su acompanante       ||');
			writeln('||............................................................................||');

		repeat
			textcolor(white);
			writeln('||............................................................................||');
			write('|| Nombre del acompanante: ');
			readln(clienteAcompanado.nombre);
		until clienteAcompanado.nombre <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Apellido del acompanante: ');
			readln(clienteAcompanado.apellido);
		until clienteAcompanado.apellido <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Numero de cedula del acompanante: ');
			readln(clienteAcompanado.cedula);
		until clienteAcompanado.cedula <> '';

		repeat
			writeln('||............................................................................||');
			write('|| E-mail del acompanante: ');
			readln(clienteAcompanado.email);
		until clienteAcompanado.email <> '';

		repeat
			writeln('||............................................................................||');
			write('|| Numero de telefono del acompanante: ');
			readln(clienteAcompanado.telefono);
		until clienteAcompanado.telefono <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Edad del acompanante: ');
			readln(clienteAcompanado.edad);
		until clienteAcompanado.edad <> '';
		end; {FIN DE REPETIR LOS DATOS}
		
		//VERIFICAMOS SI LA CEDULA YA FUE REGISTRADA
		
		reset(archivoClienteAcompanado);

		while not EOF(archivoClienteAcompanado) do
			begin {inicio verificar si cedula existe}
				read(archivoClienteAcompanado, linea);
				if Pos(clienteAcompanado.cedula, linea) > 0 then
				begin
					cedulaExistente := true;
					break;
				end;
			end; {fin verificar si cedula existe}
		
		if cedulaExistente = true then
		begin
			writeln('|| El cliente ya se encuentra registrado. ||');
		end;
		
		Close(archivoClienteAcompanado);
	end; {fin if}
	
END; {FIN DEL PROCEDIMIENTO REGISTRO-ACOMPANADO}

//PROCEDIMIENTO PARA PEDIR DATOS AL USUARIO EN EL REGISTRO GRUPO/FAMILIA

procedure registroGrupo_Familia();
var 
	cedulaExistente: boolean;
	linea: string;
BEGIN {INICIO DEL PROCEDIMIENTO REGISTRO-GRUPO_FAMILIA}
	if cantPersonas3 < 2000 then
	begin {inicio if}
	
	textcolor(white);
	writeln('||............................................................................||');
	writeln('|| Indique la cantidad de adultos que conforman el grupo                      ||');
	write('|| Adultos: ');
	readln(adultos);

	writeln('||............................................................................||');
	writeln('||Si tiene hijos, indique la cantidad de ninos que conforman el grupo         ||');
	write('|| ninos: ');
	readln(ninos);
	
	totalGrupo := adultos + ninos;
	
	for i := 1 to totalGrupo do
		begin {inicio del for}
		cantPersonas3 := cantPersonas3 + 1;
		cedulaExistente := false;
		
		{inicializamos el archivo}
		
		assign(archivoGrupoFamilia, 'clienteGrupoFamilia.dat');
		
		{creamos el archivo si no existe}
		
		if not FileExists('clienteGrupoFamilia.dat') then
		Rewrite(archivoGrupoFamilia);
		
		textcolor(yellow);
		writeln('||............................................................................||');
		writeln('||    Por favor, indique los siguientes datos para su proceso de registro     ||');
		writeln('||............................................................................||');
			
		repeat
			textcolor(white);
			writeln('||............................................................................||');
			write('|| Nombre: ');
			readln(clienteGrupoFamilia.nombre);
		until clienteGrupoFamilia.nombre <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Apellido: ');
			readln(clienteGrupoFamilia.apellido);
		until clienteGrupoFamilia.apellido <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Numero de cedula: ');
			readln(clienteGrupoFamilia.cedula);
		until clienteGrupoFamilia.cedula <> '';

		repeat
			writeln('||............................................................................||');
			write('|| E-mail: ');
			readln(clienteGrupoFamilia.email);
		until clienteGrupoFamilia.email <> '';

		repeat
			writeln('||............................................................................||');
			write('|| Numero de telefono: ');
			readln(clienteGrupoFamilia.telefono);
		until clienteGrupoFamilia.telefono <> '';
		
		repeat
			writeln('||............................................................................||');
			write('|| Edad: ');
			readln(clienteGrupoFamilia.edad);
		until clienteGrupoFamilia.edad <> '';
		
		clrscr;
		
	end; {fin del for}
	end; {fin if}
	
		//VERIFICAMOS SI LA CEDULA YA FUE REGISTRADA
		
		reset(archivoGrupoFamilia);

		while not EOF(archivoGrupoFamilia) do
			begin {inicio verificar si cedula existe}
				read(archivoGrupoFamilia, linea);
				if Pos(clienteGrupoFamilia.cedula, linea) > 0 then
				begin
					cedulaExistente := true;
					break;
				end;
			end; {fin verificar si cedula existe}
		
		if cedulaExistente = true then
		begin
			writeln('|| El cliente ya se encuentra registrado. ||');
		end;
		
		Close(archivoGrupoFamilia);
END; {FIN DEL PROCEDIMIENTO REGISTRO-GRUPO_FAMILIA}

//INICIALIZAMOS EL PROGRAMA

BEGIN {INICIO DEL PROGRAMA PRINCIPAL}

//INICIAMOS LAS CANTIDADES DE PERSONAS Y HABITACIONES EN CERO

	cantPersonas1 := 0;
	cantPersonas2 := 0;
	cantPersonas3 := 0;
	habitacion := 0;
	
	textcolor(lightcyan);
	writeln('||****************************************************************************||');
	writeln('||                               BIENVENIDO                                   ||');
	writeln('||                    "HOTEL LIDOTEL BOUTIQUE MARGARITA"                      ||');
	writeln('||****************************************************************************||');
	
	writeln('');
	textcolor(white);
	writeln('||****************************************************************************||');
	writeln('||                               MENU DE INICIO                               ||');
	writeln('||****************************************************************************||');
	writeln('||--------------------------| (1) Nuevo Cliente       |-----------------------||');
	writeln('||--------------------------| (2) Registros guardados |-----------------------||');
	writeln('||--------------------------| (3) Salir               |-----------------------||');
	writeln('||****************************************************************************||');
	write('|| Indique su opcion a elegir y presione "ENTER": ');
	readln(op);
	
	while (op <> 1) and (op <> 2) and (op <> 3) do
	begin {INICIO DEL WHILE}
		writeln('');
		textcolor(lightred);
		writeln('||============================================================================||');
		writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                  ||');
		writeln('||============================================================================||');
		textcolor(white);
		write('|| Indique su opcion a elegir y presione "ENTER": ');
		readln(op);
	end; {FIN DEL WHILE}
	
	//INICIAMOS UN CASE PARA SABER LA SELECCION DEL USUARIO EN EL MENU DE INICIO
	
	case op of {CASE PARA LAS OPCIONES DEL MENU DE INICIO}
	1: begin {INICIO DE LA OPCION "NUEVO CLIENTE"}
		clrscr;
		writeln('||****************************************************************************||');
		writeln('||                                                                            ||');
		writeln('||                       INDIQUE SU TIPO DE RESERVACION                       ||');
		writeln('||                                                                            ||');
		writeln('||****************************************************************************||');
		writeln('||                       (1) Reservacion individual                           ||');
		writeln('||----------------------------------------------------------------------------||');
		writeln('||                       (2) Reservacion acompanado                           ||');
		writeln('||----------------------------------------------------------------------------||');
		writeln('||                       (3) Reservacion Grupal/Familiar                      ||');
		writeln('||****************************************************************************||');
		write('|| Indique su opcion a elegir y presione "ENTER": ');
		readln(op);
		
		while (op <> 1) and (op <> 2) and (op <> 3) do
		begin {INICIO DEL WHILE}
		writeln('');
		textcolor(lightred);
		writeln('||============================================================================||');
		writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                  ||');
		writeln('||============================================================================||');
		textcolor(white);
		write('|| Indique su opcion a elegir y presione "ENTER": ');
		readln(op);
		end; {FIN DEL WHILE}
		
			//INICIAMOS UN SEGUNDO CASE PARA SABER EL TIPO DE RESERVACION QUE DESEA REALIZAR EL USUARIO
		
			case op of {CASE PARA LA SELECCION DEL TIPO DE RESERVACION}
				1: begin {INICIO OPCION 1 - RESERVACION INDIVIDUAL}
					if cantPersonas1 < 2000 then
						BEGIN
							cantPersonas1 := cantPersonas1 + 1;
							begin {inicio para mostrar mensaje "Reservacion individual"}
								clrscr;
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||                           Reservacion Individual                           ||');
								writeln('||****************************************************************************||');
								writeln('');
								
								textcolor(white);
								registroIndividual();
								
								writeln('');
								writeln('||......................................................||');
								writeln('||Por favor, indique el tiempo de su estadia ');
								write('|| Dias de estadia: ');
								readln(cantDias);
							end; {fin para mostrar mensaje "Reservacion individual"}
							
							begin {inicio para mostrar el tipo de habitaciones}
								clrscr;
								window(1, 1, 80, 80); 
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||              INDIQUE EL TIPO DE HABITACION QUE DESEA RESERVAR              ||');
								writeln('||****************************************************************************||');
								textcolor(lightgreen);
								writeln('||                      (1) Habitacion sencilla: 60$ P/N                      ||');
								textcolor(white);
								writeln('||                      ---------- DESCRIPCION ----------                     ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, cama ||');
								writeln('||  Lidotel Royal King con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                       (2) Habitacion doble: 120$ P/N                       ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, Dos  ||');
								writeln('||  Camas Lidotel Full con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                          (3) Family Room: 200$ P/N                         ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, bano con ducha, cafetera electrica, nevera ejecutiva,   ||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio, una habitacion separada con 2 camas full, y bano con ducha.       ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                              (4) Suite: 300$ P/N                           ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, 2 banos con ducha, cafetera electrica, nevera ejecutiva,||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio y area separada con 2 sofa-cama individuales.                      ||');
								writeln('||****************************************************************************||');
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
								
							while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) do
							begin {INICIO DEL WHILE}
								
								writeln('');
								textcolor(lightred);
								writeln('||===========================================================================||');
								writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
								writeln('||===========================================================================||');
								textcolor(white);
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
							end; {FIN DEL WHILE}
							end; {fin para mostrar el tipo de habitaciones}
							
								//INICIAMOS UN CASE PARA LA SELECCION DE LA HABITACION QUE DESEA EL USUARIO
								
								case op of {CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION INDIVIDUAL"}
									1: begin {Habitacion sencilla}
										clrscr;
										habitacion := cantDias * 60;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                 USTED HA SELECCIONADO LA HABITACION SENCILLA               ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0-2 anos sin recargos.                                           ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion sencilla}
									
									2: begin {Habitacion doble}
										clrscr;
										habitacion := cantDias * 120; 
						
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                  USTED HA SELECCIONADO LA HABITACION DOBLE                 ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion doble}
									
									3: begin {Family Room}
										clrscr;
										habitacion := cantDias * 200;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                     USTED HA SELECCIONADO LA FAMILY ROOM                   ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin Family Room}
									
									4: begin {Suite}
										clrscr;
										habitacion := cantDias * 300;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                        USTED HA SELECCIONADO LA SUITE                      ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {Fin Suite}
								end; {FIN DEL CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION INDIVIDUAL"}
								
								writeln('');
								writeln('');
								textcolor(lightred);
								writeln('|| PRESIONE ENTER PARA MOSTRAR SU REGISTRO ||');
								readln();
								
								begin {inicio ingresar dinero}
									clrscr;
									writeln('');
									writeln('');
									textcolor(white);
									writeln('||****************************************||');
									writeln('||         DATOS DE SU RESERVACION        ||');
									writeln('||****************************************||');
									writeln('|| Nombre: ', clienteIndividual.nombre);
									writeln('||========================================||');
									writeln('|| Apellido: ',clienteIndividual.apellido);
									writeln('||========================================||');
									writeln('|| Cedula: ',clienteIndividual.cedula);
									writeln('||========================================||');
									writeln('|| Telefono: ',clienteIndividual.telefono);
									writeln('||========================================||');
									writeln('|| E-mail: ',clienteIndividual.email);
									writeln('||========================================||');
									writeln('|| Sus dias de estadia son: ', cantDias);
									textcolor(lightgreen);
									writeln('||========================================||');
									writeln('|| LA TOTALIDAD DE SU CUENTA SERIA DE: ', habitacion, '$');
									writeln('||****************************************||');
									
									writeln('');
									writeln('');
									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR ||');
									readln();

									textcolor(lightred);
									writeln('|| Desea editar algun dato de su Registro? (Si/no): ');
									readln(resp);
									
									if resp = 'si' then
										editarDatos := true
									else
										editarDatos := false;
										
									if resp = 'si' then
									begin {inicio editar datos}
										clrscr;
										writeln('||------------------------------------||');
										writeln('||  Indique el dato que desea editar  ||');
										writeln('||------------------------------------||');
										writeln('||           (1) Nombre               ||');
										writeln('||           (2) Apellido             ||');
										writeln('||           (3) Cedula               ||');
										writeln('||           (4) E-mail               ||');
										writeln('||           (5) Telefono             ||');
										writeln('||           (6) Dias de su estadia   ||');
										writeln('||------------------------------------||');
										readln(op);
										
										while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) and (op <> 5) and (op <> 6) do
										begin {INICIO DEL WHILE}
											textcolor(lightred);
											writeln('||===========================================================================||');
											writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
											writeln('||===========================================================================||');
											textcolor(white);
											write('|| Indique su opcion a elegir y presione "ENTER": ');
											readln(op);
										end; {FIN DEL WHILE}
									end; {fin editar datos}
									
										//CASE PARA EDITAR DATOS DEL REGISTRO
										
										case op of
										1: begin
											writeln('||............................................................................||');
											write('|| Nombre: ');
											readln(clienteIndividual.nombre);
										end;
										
										2: begin
											writeln('||............................................................................||');
											write('|| Apellido: ');
											readln(clienteIndividual.apellido);
										end;
										
										3:begin
											writeln('||............................................................................||');
											write('|| Numero de cedula: ');
											readln(clienteIndividual.cedula);
										end;
										
										4: begin
											writeln('||............................................................................||');
											write('|| E-mail: ');
											readln(clienteIndividual.email);
										end;
										
										5: begin
											writeln('||............................................................................||');
											write('|| Numero de telefono: ');
											readln(clienteIndividual.telefono);
										end;
										
										6: begin
											writeln('||............................................................................||');
											write('|| Dias de estadia: ');
											readln(cantDias);
										end;
										end; {fin del case}

									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR SU PROCESO DE PAGO ||');
									readln();
									
									writeln('');
									writeln('');
									
									clrscr;
									textcolor(white);
									writeln('||****************************************************************************||');
									write('|| Ingrese su dinero para finiquitar su reservacion: ');
									readln(pago);
									procesoCobro();
									
									textcolor(lightgreen);
									writeln('||****************************************************************************||');
									writeln('||---------------------| SU RESERVACION HA SIDO EXITOSA |---------------------||');
									writeln('||****************************************************************************||');
									
									textcolor(lightred);
									write('PRESIONE "ENTER" PARA MOSTRAR SU FACTURA');
									readkey;
									
									clrscr;
									if habitacion = 60 then
										descripcion := 'HABITACION SENCILLA';
									{-----------------------------------------}	
										if habitacion = 120 then
											descripcion := 'HABITACION DOBLE';
										{-------------------------------------}		
											if habitacion = 200 then
												descripcion := 'FAMILY ROOM';
											{--------------------------------}	
												if habitacion = 300 then
													descripcion := 'SUITE';
												{--------------------------}
												
									MostrarFacturaIndividual();
									
									{------------------------------------------}
									if habitacion = 60 then
										(clienteIndividual.nombre) := (clienteIndividual.nombre) + 'habitacion: HABITACION SENCILLA';
									{----------------------------------------------------------------------------------------------------}	
										if habitacion = 120 then
											(clienteIndividual.nombre) := (clienteIndividual.nombre) + 'habitacion: HABITACION DOBLE';
										{-------------------------------------------------------------------------------------------------}	
											if habitacion = 200 then
												(clienteIndividual.nombre) := (clienteIndividual.nombre) + 'habitacion: FAMILY ROOM';
											{--------------------------------------------------------------------------------------------}	
												if habitacion = 300 then
													(clienteIndividual.nombre) := (clienteIndividual.nombre) + 'habitacion: SUITE';
												{--------------------------------------------------------------------------------------}
								
								writeln('');
								writeln('');
								textcolor(lightred);				
								writeln('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
								readkey;
								clrscr;
							end; {fin ingresar dinero}
						END;
				end; {FIN OPCION 1 - RESERVACION INDIVIDUAL}
			
				2: begin {INICIO OPCION 2 - RESERVACION ACOMPANADO}
					if cantPersonas2 < 2000 then
						BEGIN
							cantPersonas2 := cantPersonas2 + 1;
							begin {inicio para mostrar mensaje "reservacion acompanado"}
								clrscr;
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||                           Reservacion Acompanado                           ||');
								writeln('||****************************************************************************||');
								writeln('');
								
								textcolor(white);
								registroAcompanado();
								
								writeln('');
								writeln('||......................................................||');
								writeln('||Por favor, indique el tiempo de su estadia ');
								write('|| Dias de estadia: ');
								readln(cantDias);
							end; {fin para mostrar mensaje "reservacion acompanado"}
							
							begin {inicio para mostrar el tipo de habitaciones}
								clrscr;
								window(1, 1, 80, 80); 
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||              INDIQUE EL TIPO DE HABITACION QUE DESEA RESERVAR              ||');
								writeln('||****************************************************************************||');
								textcolor(lightgreen);
								writeln('||                      (1) Habitacion sencilla: 60$ P/N                      ||');
								textcolor(white);
								writeln('||                      ---------- DESCRIPCION ----------                     ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, cama ||');
								writeln('||  Lidotel Royal King con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                       (2) Habitacion doble: 120$ P/N                       ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, Dos  ||');
								writeln('||  Camas Lidotel Full con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                          (3) Family Room: 200$ P/N                         ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, bano con ducha, cafetera electrica, nevera ejecutiva,   ||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio, una habitacion separada con 2 camas full, y bano con ducha.       ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                              (4) Suite: 300$ P/N                           ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, 2 banos con ducha, cafetera electrica, nevera ejecutiva,||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio y area separada con 2 sofa-cama individuales.                      ||');
								writeln('||****************************************************************************||');
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
							
							while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) do
							begin {INICIO DEL WHILE}
								textcolor(lightred);
								writeln('||===========================================================================||');
								writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
								writeln('||===========================================================================||');
								textcolor(white);
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
							end; {FIN DEL WHILE}
							end;{fin para mostrar el tipo de habitaciones}
							
								//INICIAMOS UN CASE PARA LA SELECCION DE LA HABITACION QUE DESEA EL USUARIO
								
								case op of {CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION ACOMPANADO"}
									1: begin {Habitacion sencilla}
										clrscr;
										habitacion := cantDias * 60;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                 USTED HA SELECCIONADO LA HABITACION SENCILLA               ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0-2 anos sin recargos.                                           ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion sencilla}
									
									2: begin {Habitacion doble}
										clrscr;
										habitacion := cantDias * 120; 
						
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                  USTED HA SELECCIONADO LA HABITACION DOBLE                 ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion doble}
									
									3: begin {Family Room}
										clrscr;
										habitacion := cantDias * 200;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                     USTED HA SELECCIONADO LA FAMILY ROOM                   ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin Family Room}
									
									4: begin {Suite}
										clrscr;
										habitacion := cantDias * 300;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                        USTED HA SELECCIONADO LA SUITE                      ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {Fin Suite}
								end; {FIN DEL CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION ACOMPANADO"}
								
								writeln('');
								writeln('');
								textcolor(lightred);
								writeln('|| PRESIONE ENTER PARA MOSTRAR SU REGISTRO ||');
								readln();
								
								begin {inicio ingresar dinero}
									clrscr;
									writeln('');
									writeln('');
									textcolor(white);
									writeln('||****************************************||');
									writeln('||         DATOS DE SU RESERVACION        ||');
									writeln('||****************************************||');
									writeln('|| Nombre: ', clienteAcompanado.nombre);
									writeln('||========================================||');
									writeln('|| Apellido: ',clienteAcompanado.apellido);
									writeln('||========================================||');
									writeln('|| Cedula: ',clienteAcompanado.cedula);
									writeln('||========================================||');
									writeln('|| Telefono: ',clienteAcompanado.telefono);
									writeln('||========================================||');
									writeln('|| E-mail: ',clienteAcompanado.email);
									writeln('||========================================||');
									writeln('|| Sus dias de estadia son: ', cantDias);
									textcolor(lightgreen);
									writeln('||========================================||');
									writeln('|| LA TOTALIDAD DE SU CUENTA SERIA DE: ', habitacion, '$');
									writeln('||****************************************||');
									
									writeln('');
									writeln('');
									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR ||');
									readln();

									textcolor(lightred);
									writeln('|| Desea editar algun dato de su Registro? (Si/no): ');
									readln(resp);
									
									if resp = 'si' then
										editarDatos := true
									else
										editarDatos := false;
									if resp = 'si' then
									begin {inicio editar datos}
										clrscr;
										writeln('||------------------------------------||');
										writeln('||  Indique el dato que desea editar  ||');
										writeln('||------------------------------------||');
										writeln('||           (1) Nombre               ||');
										writeln('||           (2) Apellido             ||');
										writeln('||           (3) Cedula               ||');
										writeln('||           (4) E-mail               ||');
										writeln('||           (5) Telefono             ||');
										writeln('||           (6) Edad                 ||');
										writeln('||           (7) Dias de su estadia   ||');
										writeln('||------------------------------------||');
										readln(op);
										
										while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) and (op <> 5) and (op <> 6) do
										begin {INICIO DEL WHILE}
											textcolor(lightred);
											writeln('||===========================================================================||');
											writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
											writeln('||===========================================================================||');
											textcolor(white);
											write('|| Indique su opcion a elegir y presione "ENTER": ');
											readln(op);
										end; {FIN DEL WHILE}
									end; {fin editar datos}
									
										//CASE PARA EDITAR DATOS DEL REGISTRO
										
										case op of
										1: begin
											writeln('||............................................................................||');
											write('|| Nombre: ');
											readln(clienteAcompanado.nombre);
										end;
										
										2: begin
											writeln('||............................................................................||');
											write('|| Apellido: ');
											readln(clienteAcompanado.apellido);
										end;
										
										3:begin
											writeln('||............................................................................||');
											write('|| Numero de cedula: ');
											readln(clienteAcompanado.cedula);
										end;
										
										4: begin
											writeln('||............................................................................||');
											write('|| E-mail: ');
											readln(clienteAcompanado.email);
										end;
										
										5: begin
											writeln('||............................................................................||');
											write('|| Numero de telefono: ');
											readln(clienteAcompanado.telefono);
										end;
										
										6: begin
											writeln('||............................................................................||');
											write('|| Edad: ');
											readln(clienteAcompanado.edad);
										end;
										
										7: begin
											writeln('||............................................................................||');
											write('|| Dias de estadia: ');
											readln(cantDias);
										end;
										end; {fin del case}
									
									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR SU PROCESO DE PAGO ||');
									readln();
									
									writeln('');
									writeln('');
									
									clrscr;
									textcolor(white);
									writeln('||****************************************************************************||');
									write('|| Ingrese su dinero para finiquitar su reservacion: ');
									readln(pago);
									procesoCobro();
								
									textcolor(lightgreen);
									writeln('||****************************************************************************||');
									writeln('||---------------------| SU RESERVACION HA SIDO EXITOSA |---------------------||');
									writeln('||****************************************************************************||');
								
									writeln('');
									writeln('');
									textcolor(lightred);
									write('PRESIONE "ENTER" PARA MOSTRAR SU FACTURA');
									readkey;
								
									clrscr;
									if habitacion = 60 then
										descripcion := 'HABITACION SENCILLA';
									{-----------------------------------------}	
										if habitacion = 120 then
											descripcion := 'HABITACION DOBLE';
										{-------------------------------------}		
											if habitacion = 200 then
												descripcion := 'FAMILY ROOM';
											{--------------------------------}	
												if habitacion = 300 then
													descripcion := 'SUITE';
												{--------------------------}
												
									MostrarFacturaAcompanado();
									
									{------------------------------------------}
									if habitacion = 60 then
										(clienteAcompanado.nombre) := (clienteAcompanado.nombre) + 'habitacion: HABITACION SENCILLA';
									{----------------------------------------------------------------------------------------------------}	
										if habitacion = 120 then
											(clienteAcompanado.nombre) := (clienteAcompanado.nombre) + 'habitacion: HABITACION DOBLE';
										{-------------------------------------------------------------------------------------------------}	
											if habitacion = 200 then
												(clienteAcompanado.nombre) := (clienteAcompanado.nombre) + 'habitacion: FAMILY ROOM';
											{--------------------------------------------------------------------------------------------}	
												if habitacion = 300 then
													(clienteAcompanado.nombre) := (clienteAcompanado.nombre) + 'habitacion: SUITE';
												{--------------------------------------------------------------------------------------}
									
									writeln('');
									writeln('');
									textcolor(lightred);			
									writeln('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
									readkey;
									clrscr;
								end; {fin totalidad cuenta}
						END;
				end; {FIN OPCION 2 - RESERVACION ACOMPANADO}
			
				3: begin {INICIO OPCION 3 - RESERVACION GRUPO/FAMILIA}
					if cantPersonas3 < 2000 then
						BEGIN
							begin {inicio para mostrar mensaje "reservacion grupo/familia" y preguntar la cantidad de niños y adultos}
								clrscr;
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||                           Reservacion Grupo/Familia                        ||');
								writeln('||****************************************************************************||');
								writeln('');
								
								registroGrupo_Familia();
								
								writeln('');
								writeln('||......................................................||');
								writeln('||Por favor, indique el tiempo de su estadia ');
								write('|| Dias de estadia: ');
								readln(cantDias);
								
								clrscr;
								writeln('');
								textcolor(lightred);
								write('||PRESIONE ENTER PARA ACCEDER A LAS HABITACIONES DISPONIBLES||');
								readkey;
							end; {fin para mostrar mensaje "reservacion grupo/familia" y preguntar la cantidad de niños y adultos}
							
							begin {inicio para mostrar el tipo de habitaciones}
								clrscr;
								window(1, 1, 80, 80); 
								textcolor(yellow);
								writeln('||****************************************************************************||');
								writeln('||              INDIQUE EL TIPO DE HABITACION QUE DESEA RESERVAR              ||');
								writeln('||****************************************************************************||');
								textcolor(lightgreen);
								writeln('||                      (1) Habitacion sencilla: 60$ P/N                      ||');
								textcolor(white);
								writeln('||                      ---------- DESCRIPCION ----------                     ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, cama ||');
								writeln('||  Lidotel Royal King con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                       (2) Habitacion doble: 120$ P/N                       ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Amplia y confortable habitacion decorada con un estilo vanguardista, Dos  ||');
								writeln('||  Camas Lidotel Full con sabanas de algodon egipcio, soporte para iPod con  ||');
								writeln('||  reloj despertador, TV 32in HD Plasma con cable, bano con ducha, cafetera  ||');
								writeln('||  electrica, nevera ejecutiva, caja electronica de seguridad y secador      ||');
								writeln('||  de cabello.                                                               ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                          (3) Family Room: 200$ P/N                         ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, bano con ducha, cafetera electrica, nevera ejecutiva,   ||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio, una habitacion separada con 2 camas full, y bano con ducha.       ||');
								writeln('||----------------------------------------------------------------------------||');
								textcolor(lightgreen);
								writeln('||                              (4) Suite: 300$ P/N                           ||');
								textcolor(white);
								writeln('||                     ---------- DESCRIPCION ----------                      ||');
								writeln('||  Calida y confortable habitacion decorada con un estilo vanguardista, 100% ||');
								writeln('||  libre de humo, cama Lidotel Royal King, con reloj despertador, TV 32in HD ||');
								writeln('||  Plasma con cable, 2 banos con ducha, cafetera electrica, nevera ejecutiva,||');
								writeln('||  caja electronica de seguridad, secador de cabello, armario adicional      ||');
								writeln('||  amplio y area separada con 2 sofa-cama individuales.                      ||');
								writeln('||****************************************************************************||');
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
							
							while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) do
							begin {INICIO DEL WHILE}
								textcolor(lightred);
								writeln('||===========================================================================||');
								writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
								writeln('||===========================================================================||');
								textcolor(white);
								write('|| Indique su opcion a elegir y presione "ENTER": ');
								readln(op);
							end; {FIN DEL WHILE}
							end; {fin para mostrar el tipo de habitaciones}
							
								//INICIAMOS UN CASE PARA LA SELECCION DE LA HABITACION QUE DESEA EL USUARIO
								
								case op of {CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION GRUPO/FAMILIA"}
									1: begin {Habitacion sencilla}
										clrscr;
										habitacion := cantDias * 60;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                 USTED HA SELECCIONADO LA HABITACION SENCILLA               ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0-2 anos sin recargos.                                           ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion sencilla}
									
									2: begin {Habitacion doble}
										clrscr;
										habitacion := cantDias * 120; 
						
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                  USTED HA SELECCIONADO LA HABITACION DOBLE                 ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a las instalaciones del Business Center, uso de nuestra    ||');
										writeln('||  exclusiva piscina, acceso a nuestro moderno gimnasio y Kit de vanidades.  ||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin habitacion doble}
									
									3: begin {Family Room}
										clrscr;
										habitacion := cantDias * 200;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                     USTED HA SELECCIONADO LA FAMILY ROOM                   ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {fin Family Room}
									
									4: begin {Suite}
										clrscr;
										habitacion := cantDias * 300;
										
										window(1, 1, 80, 30);
										textcolor(yellow);
										writeln('||****************************************************************************||');
										writeln('||                        USTED HA SELECCIONADO LA SUITE                      ||');
										writeln('||****************************************************************************||');
										textcolor(white);
										writeln('||                 ---------- SU RESERVACION INCLUYE ----------               ||');
										writeln('||  Desayuno Buffet en Restaurant Le Nouveau, acceso inalambrico a Internet   ||');
										writeln('||  (WIFI), acceso a Business Center, uso de nuestra exclusiva piscina, acceso||');
										writeln('||  a nuestro moderno gimnasio, sillas y toldos en la playa y Kit de vanidades||');
										writeln('||  Ninos de 0 a 2 anos sin recargos.                                         ||');
										writeln('||----------------------------------------------------------------------------||');
										writeln('||  Si desea realizar la reservacion, presione el numero 1 y luego ENTER.     ||');
										write('|| Numero: ');
										readln(resp);
									end; {Fin Suite}
								end; {FIN DEL CASE PARA LA SELECCION DE LA HABITACION EN "RESERVACION GRUPO/FAMILIA"}
								
								writeln('');
								writeln('');
								textcolor(lightred);
								writeln('|| PRESIONE ENTER PARA MOSTRAR SU REGISTRO ||');
								readln();
								
								begin {inicio ingresar dinero}
									editarDatos := false;
									
									clrscr;
									writeln('');
									writeln('');
									textcolor(white);
									writeln('||****************************************||');
									writeln('||         DATOS DE SU RESERVACION        ||');
									writeln('||****************************************||');
									writeln('|| Nombre: ', clienteGrupoFamilia.nombre);
									writeln('||========================================||');
									writeln('|| Apellido: ',clienteGrupoFamilia.apellido);
									writeln('||========================================||');
									writeln('|| Cedula: ',clienteGrupoFamilia.cedula);
									writeln('||========================================||');
									writeln('|| Telefono: ',clienteGrupoFamilia.telefono);
									writeln('||========================================||');
									writeln('|| E-mail: ',clienteGrupoFamilia.email);
									writeln('||========================================||');
									writeln('|| Sus dias de estadia son: ', cantDias);
									textcolor(lightgreen);
									writeln('||========================================||');
									writeln('|| LA TOTALIDAD DE SU CUENTA SERIA DE: ', habitacion, '$');
									writeln('||****************************************||');
									
									writeln('');
									writeln('');
									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR ||');
									readln();
									
									textcolor(lightred);
									writeln('|| Desea editar algun dato de su Registro? (Si/no): ');
									readln(resp);
									
									textcolor(white);
									if resp = 'si' then
										editarDatos := true
									else
										editarDatos := false;	
									if resp = 'si' then
									begin {inicio editar datos}
										clrscr;
										writeln('||------------------------------------||');
										writeln('||  Indique el dato que desea editar  ||');
										writeln('||------------------------------------||');
										writeln('||           (1) Nombre               ||');
										writeln('||           (2) Apellido             ||');
										writeln('||           (3) Cedula               ||');
										writeln('||           (4) E-mail               ||');
										writeln('||           (5) Telefono             ||');
										writeln('||           (6) Edad                 ||');
										writeln('||           (7) Dias de su estadia   ||');
										writeln('||------------------------------------||');
										readln(op);
										
										while (op <> 1) and (op <> 2) and (op <> 3) and (op <> 4) and (op <> 5) and (op <> 6) do
										begin {INICIO DEL WHILE}
											textcolor(lightred);
											writeln('||===========================================================================||');
											writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                 ||');
											writeln('||===========================================================================||');
											textcolor(white);
											write('|| Indique su opcion a elegir y presione "ENTER": ');
											readln(op);
										end; {FIN DEL WHILE}
									end; {fin editar datos}
									
										//CASE PARA EDITAR DATOS DEL REGISTRO
										
										case op of
										1: begin
											writeln('||............................................................................||');
											write('|| Nombre: ');
											readln(clienteGrupoFamilia.nombre);
										end;
										
										2: begin
											writeln('||............................................................................||');
											write('|| Apellido: ');
											readln(clienteGrupoFamilia.apellido);
										end;
										
										3:begin
											writeln('||............................................................................||');
											write('|| Numero de cedula: ');
											readln(clienteGrupoFamilia.cedula);
										end;
										
										4: begin
											writeln('||............................................................................||');
											write('|| E-mail: ');
											readln(clienteGrupoFamilia.email);
										end;
										
										5: begin
											writeln('||............................................................................||');
											write('|| Numero de telefono: ');
											readln(clienteGrupoFamilia.telefono);
										end;
										
										6: begin
											writeln('||............................................................................||');
											write('|| Edad: ');
											readln(clienteAcompanado.edad);
										end;
										
										7: begin
											writeln('||............................................................................||');
											write('|| Dias de estadia: ');
											readln(cantDias);
										end;
										end; {fin del case}

									textcolor(lightred);
									writeln('|| PRESIONE ENTER PARA CONTINUAR SU PROCESO DE PAGO ||');
									readln();
									
									writeln('');
									writeln('');
									
									clrscr;
									textcolor(white);
									writeln('||****************************************************************************||');
									write('|| Ingrese su dinero para finiquitar su reservacion: ');
									readln(pago);
									procesoCobro();
								
									textcolor(lightgreen);
									writeln('||****************************************************************************||');
									writeln('||---------------------| SU RESERVACION HA SIDO EXITOSA |---------------------||');
									writeln('||****************************************************************************||');
									write('PRESIONE "ENTER" PARA MOSTRAR SU FACTURA');
									readkey;
									
									clrscr;
									if habitacion = 60 then
										descripcion := 'HABITACION SENCILLA';
									{-----------------------------------------}	
										if habitacion = 120 then
											descripcion := 'HABITACION DOBLE';
										{-------------------------------------}		
											if habitacion = 200 then
												descripcion := 'FAMILY ROOM';
											{--------------------------------}	
												if habitacion = 300 then
													descripcion := 'SUITE';
												{--------------------------}
												
									MostrarFacturaGrupo_Familia();
									
									{------------------------------------------}
									if habitacion = 60 then
										(clienteGrupoFamilia.nombre) := (clienteGrupoFamilia.nombre) + 'habitacion: HABITACION SENCILLA';
									{----------------------------------------------------------------------------------------------------}	
										if habitacion = 120 then
											(clienteGrupoFamilia.nombre) := (clienteGrupoFamilia.nombre) + 'habitacion: HABITACION DOBLE';
										{-------------------------------------------------------------------------------------------------}	
											if habitacion = 200 then
												(clienteGrupoFamilia.nombre) := (clienteGrupoFamilia.nombre) + 'habitacion: FAMILY ROOM';
											{--------------------------------------------------------------------------------------------}	
												if habitacion = 300 then
													(clienteGrupoFamilia.nombre) := (clienteGrupoFamilia.nombre) + 'habitacion: SUITE';
												{--------------------------------------------------------------------------------------}
									
									textcolor(lightred);			
									writeln('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
									readkey;
									clrscr;
								end; {fin totalidad cuenta}
						END;
				end; {FIN OPCION 3 - RESERVACION GRUPO/FAMILIA}
			
			end; {FIN DEL CASE PARA LA SELECCION DEL TIPO DE RESERVACION}
			
	end; {FIN DE LA OPCION "NUEVO CLIENTE"}
	
	2: begin {INICIO DE LA OPCION "REGISTROS GUARDADOS"}
	clrscr;
	textcolor(white);
	writeln('||********************************************************************************||');
	writeln('||                                                                                ||');
	writeln('||                               REGISTROS GUARDADOS                              ||');
	writeln('||                                                                                ||');
	writeln('||********************************************************************************||');
	writeln('||                           (1) Registros individuales                           ||');
	writeln('||--------------------------------------------------------------------------------||');
	writeln('||                           (2) Registros Acompanados                            ||');
	writeln('||--------------------------------------------------------------------------------||');
	writeln('||                           (3) Registros Grupo/Familia                          ||');
	writeln('||********************************************************************************||');
	write('|| Indique su opcion a elegir: ');
	readln(op);
	
	while (op <> 1) and (op <> 2) and (op <> 3) do
	begin {INICIO DEL WHILE}
		textcolor(lightred);
		writeln('||============================================================================||');
		writeln('||                   POR FAVOR, SELECCIONE UNA OPCION VALIDA                  ||');
		writeln('||============================================================================||');
		textcolor(white);
		write('|| Indique su opcion a elegir: ');
		readln(op);
	end; {FIN DEL WHILE}
	
	//INICIAMOS UN CASE DENTRO DE LA OPCION "REGISTROS GUARDADOS" PARA LA SELECCION DE LAS 3 DIFERENTES OPCIONES
	
	case op of {CASE PARA LA SELECCION DE LAS OPCIONES EN REGISTROS GUARDADOS}
	1: begin {INICIO REGISTROS INDIVIDUALES}
		if cantPersonas1 = 0 then
			begin
				textcolor(lightred);
				writeln('||*************************************||');
				writeln('||No se encontraron registros guardados||');
				writeln('||*************************************||');
			end
		
			else
			for i := 1 to cantPersonas1 do
				writeln(i, ': ', clienteIndividual.nombre);
				writeln('');
				
				textcolor(yellow);
				write('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
				readkey;
				clrscr;
	end; {FIN REGISTROS INDIVIDUALES}
	
	2: begin {INICIO REGISTROS ACOMPANADOS}
		if cantPersonas2 = 0 then
			begin
				textcolor(lightred);
				writeln('||*************************************||');
				writeln('||No se encontraron registros guardados||');
				writeln('||*************************************||');
			end
		
			else
			for i := 1 to cantPersonas2 do
				writeln(i, ': ', clienteAcompanado.nombre);
				writeln('');
				
				textcolor(yellow);
				write('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
				readkey;
				clrscr;
	end; {FIN REGISTROS ACOMPANADOS}
	
	3: begin {INICIO REGISTROS GRUPO/FAMILIA}
	if cantPersonas3 = 0 then
			begin
				textcolor(lightred);
				writeln('||*************************************||');
				writeln('||No se encontraron registros guardados||');
				writeln('||*************************************||');
			end
		
			else
			for i := 1 to cantPersonas3 do
				writeln(i, ': ', clienteGrupoFamilia.nombre);
				writeln('');
				
				textcolor(yellow);
				write('||PRESIONE ENTER PARA VOLVER AL MENU DE INICIO||');
				readkey;
				clrscr;
	end; {FIN REGISTROS GRUPO/FAMILIA}
	
	end; {FIN DEL CASE PARA LA SELECCION DE LAS OPCIONES EN REGISTROS GUARDADOS}
	
	end; {FIN DE LA OPCION "REGISTROS GUARDADOS"}
	
	end; {FIN DEL CASE PARA LAS OPCIONES DEL MENU DE INICIO}
	
END. {FIN DEL PROGRAMA PRINCIPAL}
