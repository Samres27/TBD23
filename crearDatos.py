import sqlite3

class consSql:
    def tranforDatosFecha(self,archivo):
        
        textesp=archivo.split(".")
        archivoE=textesp[0]+"m."+textesp[-1]
        lsmes=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        try:
            arc=open(archivo,'r',encoding="utf8")
            arc2=open(archivoE,"w",encoding="utf8")
            lsPl=arc.readlines()
            lsAC=[]
            for x in lsPl:
                lsx= x.split("'")
                nvLs=[]
                for w in  lsx:
                    num=1
                    lsn=[]
                    for y in lsmes:
                        esAm=w[:3]
                        if y == esAm and w[3]==" ":
                            lsy=w.split(" ");
                            aas=""
                            if num<10: 
                                aas="0"+str(num) 
                            else: aas=str(num)
                            if len(lsy[1])==2: 
                                lsy[1]="0"+lsy[1] 
                            
                            w= lsy[2]+"-"+aas+"-"+lsy[1][:-1]
                            break;
                        num+=1;
                    nvLs.append(w)
                lsAC.append("'".join(nvLs))
            arc2.writelines(lsAC)
        except:
            print("no se pudo manejar"+archivo+" o "+archivoE)
    def crearBaseDatos(script,nomBD):
        return None;
    
    def consulta1():
        #Mostrar las canciones de loa álbumes producidos por Sony Music, entre los 
        #años 2022 a la fecha.
        
        con=sqlite3.connect("baseDatos//TDB.db")
        
        cons='''select nombrealbum,nombrecancion 
                from financia,album, EMPRESAPRODUCTORA,cancion 
                where 
                    financia.idalbum=album.idalbum and empresaproductora.idempresa=financia.idempresa and 
                    album.idalbum = cancion.idalbum and nombreempresa='Sony Music'and cast(strftime('%Y',ANIOESTRENO) as integer)  >= 2022;'''
        cur = con.execute(cons)
        for x in cur:    
            print(x)
    
    
    
    def consulta2():
        #Mostrar los nombres de los ganadores a mejor artista en los eventos Billboard 
        #2022 y Grammy 2022, la ciudad, le fecha y el país en el que se realizó.
        
        con=sqlite3.connect("baseDatos//TDB.db")
        
        cons='''select nombreartista, nombreevento, fechaevento, nombrepais 
                from evento, nominado, artista, ciudad 
                where evento.idEvento == nominado.idevento 
                    and artista.idartista=nominado.idartista and evento.nombreciudad =ciudad.nombreciudad 
                    and premiado==1 and (nombreevento=='Grammy' or nombreevento=='Billboard') 
                    and FECHAEVENTO like '%2022%' ;'''
        cur = con.execute(cons)
        for x in cur:    
            print(x)
    
    
    def consulta3():
        #Mostrar la oferta, fecha de inicio y fecha de fin de las suscripciones de Juan 
        #Pérez. si su modalidad de pago fue al contado o al crédito.
        con=sqlite3.connect("baseDatos//TDB.db")
            
        cons='''select idoferta,iniciooferta, finoferta, FORMAPAGOSUSP  
                from suscripcion,oferta,cuentausuario,cliente 
                    where cuentausuario.idcu == oferta.idcu and 
                    suscripcion.idsuscripcion== oferta.idsuscripcion and 
                    cuentaUsuario.idcliente = cliente.idcliente and 
                    nombrecliente=='Juan Perez'; '''
        cur = con.execute(cons)
        for x in cur:    
            print(x)
    
    def consulta4():
        #Mostrar los nombres de los componentes de grupo de Rock latino Maná, la 
        #procedencia de cada uno (ciudad y país de nacimiento), y que actividad 
        #cumple cada uno en el grupo, esto es vocalista, guitarra, etc.
        con=sqlite3.connect("baseDatos//TDB.db")
            
        cons='''select nombreGrupo,nombreartista, nombreciudad, paisartista,rolartista 
                from grupomusical,artista where grupomusical.idgrupo==artista.idgrupo 
                and nombreGrupo=='Mana' and generoMusical=='Rock&Roll';'''
        cur = con.execute(cons)
        for x in cur:    
            print(x)
            
    def consulta5():
        #Mostrar el ranking de las 10 listas más escuchadas del mes de septiembre, junto 
        #al nombre del usuario del creador de cada una de las 10 listas del ranking.
        con=sqlite3.connect("baseDatos//TDB.db")
            
        cons='''select logincu, NOMBRELISTAREPRODUCCION from
                LISTAREPRODUCCION , cuentausuario 
                where LISTAREPRODUCCION.idcu == cuentausuario.idcu 
                and (listareproduccion.idcu,NOMBRELISTAREPRODUCCION) 
                in (select idcu,NOMBRELISTAREPRODUCCION 
                                from REPRODUCCIONPORLISTA,LISTAREPRODUCCION 
                                where REPRODUCCIONPORLISTA.idLISTAREPRODUCCION == 
                                    LISTAREPRODUCCION.idLISTAREPRODUCCION and 
                                    FECHAREPRODUCCION like '%2022%%9%' group 
                                    by NOMBRELISTAREPRODUCCION order by count() DESC limit 10);'''
        cur = con.execute(cons)
        for x in cur:    
            print(x)
            
        con.executescript
    
    
    def consulta6():
        #Mostrar la lista de canciones de la lista top del mes de septiembre, de cada
        #canción se debe mostrar el nombre o titulo de la canción, genero, artista que la 
        #interpreta.
        con=sqlite3.connect("baseDatos//TDB.db")     
        cons='''select nombreCancion,generoMusical, nombreautor 
                    from REPRODUCCIONPORLISTA,LISTAREPRODUCCION 
                                                    where REPRODUCCIONPORLISTA.idLISTAREPRODUCCION == 
                                                            LISTAREPRODUCCION.idLISTAREPRODUCCION and 
                                                            FECHAREPRODUCCION like '%2022%%9%' 
                                                            group by NOMBRELISTAREPRODUCCION 
                                                            order by count() DESC limit 1);'''
        cur = con.execute(cons)
        
        for x in cur:
            print(x)

    def cargarDatos(ubicacion):
        try:
            con=sqlite3.connect("baseDatos//TDB.db")     
            textS=open(ubicacion,"r")
            textScript=textS.read()
            cursor = con.cursor()
            cursor.executescript(textScript)
        except:
            print("error en aguna parte cargarDatos")
    def cargarDatos(self,ubicacion):
        con=sqlite3.connect("baseDatos//TDB.db")     
        
        try:
            textS=open(ubicacion,"r",encoding="utf8")
            textScript=textS.read()
            cursor = con.cursor()
            cursor.executescript(textScript)
        except Exception as er:
            print("error en aguna parte cargarDatos",er, ubicacion )
    def cargarDatosDef(self):
        for x in range(1,27):
            arcUbica="baseDatos//" +str(x)+"m.sql"
            self.cargarDatos(arcUbica)
            
    def cargarModelo(self):
        ubicacion="baseDatos//baseMod.sql"
        con=sqlite3.connect("baseDatos//TDB.db")     
        try:
            textS=open(ubicacion,"r",encoding="utf8")
            textScript=textS.read()
            cursor = con.cursor()
            cursor.executescript(textScript)
        except Exception as er:
            print("error en aguna parte cargarDatos",er, ubicacion )
    def cargarDatosModelo(self):
        for x in range(1,27):
            self.tranforDatosFecha("baseDatos//"+str(x)+".sql")
        self.cargarModelo()   
        self.cargarDatosDef()
        
            


cs=consSql()
cs.cargarDatosModelo();
